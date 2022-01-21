const request = {
  reject: 0,
  accept: 1,
  pending: 2,
  canceled: 3,
};

import functions = require("firebase-functions");

import admin = require("firebase-admin");
admin.initializeApp();


/**
 * Get fcm tokens of user
 * @param {string} userId Id of the user to get tokens of
 * @return {Promise<string[]>} Promise of list of fcm tokens
 */
async function getUserFcmTokens(userId: string): Promise<string[]> {
  return Object.keys((await admin.database()
      .ref(`/users/${userId}/fcmTokens`)
      .once("value"))
      .val());
}

exports.signUp = functions.firestore
    .document("User/{uid}")
    .onCreate(async (change, context) => {
      const data = change.data();
      const userCounter = admin.database()
          .ref("userCounter");
      const userCounterVal = (await userCounter.once("value")).val();
      const responses = [];
      responses.push(await admin.database().ref(`/users/${context.params.uid}`)
          .set({isReal: true, name: data.Name, surname: data.Surname,
            email: data.Email, publicId: `U${userCounterVal}`}));
      responses.push(await admin.database()
          .ref(`/publicUserIds/U${userCounterVal}`).set(context.params.uid));
      responses.push(await admin.database().ref().update({userCounter: admin
          .database.ServerValue.increment(1)}));
      return responses;
    });

exports.childNotification = functions.database
    .ref("/routes/{routeId}/passengers/{childId}/isOn")
    .onUpdate(async (change, context) => {
      const isOn = change.after.val();
      const childId = context.params.childId;

      const childValue = (await admin.database().ref(`/users/${childId}`)
          .once("value"))
          .val();

      const status = isOn ? "servise bindi." : "servisten indi.";
      const payload = {
        notification:
        {
          title: `${childValue.name} ${childValue.surname}`,
          body: `${childValue.name} ${status}`,
        },
      };

      const parents = Object.keys(childValue.parents);
      const responses: admin.messaging.MessagingDevicesResponse[] = [];

      parents.forEach(async (parentId) => {
        const fcmTokens = await getUserFcmTokens(parentId);

        functions.logger.log("Sending notification about",
            childValue.name, "to their parent",
            (await admin.database().ref(`/users/${parentId}/name`)
                .once("value"))
                .val(),
            ` with the tokens ${fcmTokens}`);

        const response = await admin.messaging()
            .sendToDevice(fcmTokens, payload);
        responses.push(response);
      });
      return responses;
    });

exports.receivedConnectionRequestCreate = functions.database
    .ref("/users/{toId}/pendingUsers/{fromId}")
    .onCreate(async (change, context) => {
      const reqVal = change.val();

      switch (reqVal) {
        case request.pending: // pending
        {
          const fromUserVal = (await admin.database()
              .ref(`/users/${context.params.fromId}`)
              .once("value")).val();
          const payload = {
            notification: {
              title: "Bağlantı İsteği",
              body: `${fromUserVal.name} ${fromUserVal.surname} \
bağlantı isteği yolladı.`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "connectionRequestReceive",
              value: "2",
            },
          };
          const response = admin.messaging()
              .sendToDevice(await getUserFcmTokens(context.params.toId),
                  payload);
          return response;
        }
        default:
        {
          return functions.logger
              .log("Unexpected request value:", reqVal);
        }
      }
    });

exports.receivedConnectionRequestUpdate = functions.database
    .ref("/users/{toId}/pendingUsers/{fromId}")
    .onUpdate(async (change, context) => {
      const toId = context.params.toId;
      const fromId = context.params.fromId;
      const reqVal = change.after.val();

      change.after.ref.remove();
      admin.database().ref(`/users/${fromId}/sentUsers/${fromId}`).remove();

      const toUserVal = (await admin.database()
          .ref(`/users/${toId}`)
          .once("value")).val();
      const toUserNameSurname = `${toUserVal.name} ${toUserVal.surname}`;

      switch (reqVal) {
        case request.reject: // rejected
        {
          await change.after.ref.remove();
          await admin.database()
              .ref(`/users/${fromId}/sentUsers/${toId}`).remove();
          const payload = {
            notification: {
              title: "Bağlantı Reddi",
              body: `${toUserNameSurname} \
bağlantı isteğinizi reddetti.`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "connectionRequestRespond",
              value: "0",
            },
          };
          const response = await admin.messaging()
              .sendToDevice(await getUserFcmTokens(fromId),
                  payload);
          return response;
        }
        case request.accept: // accepted
        {
          const payload = {
            notification: {
              title: "Bağlantı Onayı",
              body: `${toUserNameSurname} \
bağlantı isteğinizi onayladı.`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "connectionRequestRespond",
              value: "1",
            },
          };

          const responses = [change.after.ref.remove(),
            admin.database().ref(`/users/${fromId}/sentUsers/${toId}`).remove(),
            admin.database().ref(`/users/${fromId}/children/${toId}`).set(true),
            admin.database().ref(`/users/${toId}/parents/${fromId}`).set(true),
            admin.messaging()
                .sendToDevice(await getUserFcmTokens(fromId), payload),
          ];

          return Promise.all(responses);
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.receivedRouteSubRequestCreate = functions.database
    .ref("/routes/{routeId}/pendingUsers/{userId}")
    .onCreate(async (change, context) => {
      const reqVal = change.val();

      switch (reqVal) {
        case request.pending: // pending
        {
          const userVal = (await admin.database()
              .ref(`/users/${context.params.userId}`)
              .once("value")).val();
          const payload = {
            notification: {
              title: "Abone İsteği",
              body: `${userVal.name} ${userVal.surname} \
abone isteği yolladı.`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "routeSubRequestReceive",
              value: "2",
            },
          };
          const shuttleId = (await admin.database()
              .ref(`/routes/${context.params.routeId}/shuttleId`)
              .once("value")).val();
          const employees = Object.keys((await admin.database()
              .ref(`/shuttles/${shuttleId}/employees`)
              .once("value")).val());
          const responses: admin.messaging.MessagingDevicesResponse[] = [];
          employees.forEach(async (employeeId) => {
            const fcmTokens = await getUserFcmTokens(employeeId);
            const response = await admin.messaging()
                .sendToDevice(fcmTokens, payload);
            responses.push(response);
          });
          return responses;
        }
        default:
        {
          return functions.logger
              .log("Unexpected request value:", reqVal);
        }
      }
    });

exports.receivedRouteSubRequestUpdate = functions.database
    .ref("/routes/{routeId}/pendingUsers/{userId}")
    .onUpdate(async (change, context) => {
      const reqVal = change.after.val();
      const userId = context.params.userId;
      const routeId = context.params.routeId;

      change.after.ref.remove();
      admin.database()
          .ref(`/users/${userId}/sentRoutes/${routeId}`)
          .remove();

      const userVal = (await admin.database()
          .ref(`/users/${userId}`)
          .once("value")).val();

      switch (reqVal) {
        case request.reject: // rejected
        {
          const payload = {
            notification: {
              title: "Abone Reddi",
              body: `${context.params.routeId} \
rotası için olan abonelik isteğiniz reddedildi.`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "routeSubRequestRespond",
              value: "0",
            },
          };
          const responses = [];
          if (userVal.isReal) {
            responses.push(admin.messaging()
                .sendToDevice(await getUserFcmTokens(userId),
                    payload));
          } else {
            Object.keys(userVal.parents).forEach(async (parentId: string) => {
              responses.push(admin.messaging()
                  .sendToDevice(await getUserFcmTokens(parentId), payload));
            });
          }
          return Promise.all(responses);
        }
        case request.accept: // accepted
        {
          const payload = {
            notification: {
              title: "Abone Onayı",
              body: `${context.params.routeId} \
rotası için olan abonelik isteğiniz onaylandı.`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "routeSubRequestRespond",
              value: "1",
            },
          };
          const responses = [];
          responses.push(admin.database()
              .ref(`/users/${userId}/routes/${routeId}`).set(false));
          responses.push(admin.database()
              .ref(`/routes/${routeId}/passengers/${userId}`).set({
                isOn: false,
                status: 0,
              }));
          if (userVal.isReal) {
            responses.push(admin.messaging()
                .sendToDevice(await getUserFcmTokens(context.params.userId),
                    payload));
          } else {
            Object.keys(userVal.parents).forEach(async (parentId: string) => {
              responses.push(admin.messaging()
                  .sendToDevice(await getUserFcmTokens(parentId), payload));
            });
          }
          return Promise.all(responses);
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.receivedShuttleEmployeeRequestCreate = functions.database
    .ref("/shuttles/{shuttleId}/pendingEmployees/{userId}")
    .onCreate(async (change, context) => {
      const reqVal = change.val();
      switch (reqVal) {
        case request.pending: // pending
        {
          const userId = context.params.userId;
          const userVal = (await admin.database()
              .ref(`/users/${userId}`).once("value")).val();
          const userName = userVal.name;
          const userSurname = userVal.surname;
          const shuttleRef = change.ref.parent!.parent!;
          const shuttleVal = (await shuttleRef.once("value")).val();
          const employees = Object.keys(shuttleVal.employees);
          const plate = shuttleVal.plate;
          const payload = {
            notification: {
              title: `${userName}, ${plate}`,
              body: `${userName} ${userSurname}, ${plate} plakalı servis için\
 görevli olma isteği yolladı`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "employeeRequestReceive",
              value: "2",
              shuttleId: context.params.shuttleId,
            },
          };
          const responses: admin.messaging.MessagingDevicesResponse[] = [];
          employees.forEach(async (employeeId) => {
            responses.push(await admin.messaging()
                .sendToDevice(await getUserFcmTokens(employeeId), payload));
          });
          return responses;
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.receivedShuttleEmployeeRequestUpdate = functions.database
    .ref("/shuttles/{shuttleId}/pendingEmployees/{userId}")
    .onUpdate(async (change, context) => {
      const reqVal = change.after.val();
      const userId = context.params.userId;
      const plate = (await change.after.ref.parent!.parent!
          .child("plate").once("value")).val();
      switch (reqVal) {
        case request.reject: // rejected
        {
          const payload = {
            notification: {
              title: `${plate} görevli reddi`,
              body: `${plate} plakalı servis için görevli olma isteğiniz \
reddedilmiştir`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "employeeRequestRespond",
              value: "0",
            },
          };
          const shuttleId = context.params.shuttleId;
          const responses = [];
          responses.push(change.after.ref.remove());
          responses.push(admin.database()
              .ref(`/employees/${userId}/sentShuttles/${shuttleId}`).remove());
          responses.push(admin.messaging()
              .sendToDevice(await getUserFcmTokens(userId), payload));
          return Promise.all(responses);
        }
        case request.accept: // accepted
        {
          const payload = {
            notification: {
              title: `${plate} görevli onayı`,
              body: `${plate} plakalı servis için görevli olma isteğiniz \
onaylanmıştır`,
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              type: "employeeRequestRespond",
              value: "1",
              shuttleId: context.params.shuttleId,
            },
          };
          const shuttleId = context.params.shuttleId;
          const responses = [];
          responses.push(change.after.ref.remove());
          responses.push(admin.database()
              .ref(`/employees/${userId}/sentShuttles/${shuttleId}`).remove());
          responses.push(admin.database()
              .ref(`/shuttles/${shuttleId}/employees/${userId}`).set(true));
          responses.push(admin.messaging()
              .sendToDevice(await getUserFcmTokens(userId), payload));
          return Promise.all(responses);
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.sentShuttleEmployeeRequestCreate = functions.database
    .ref("/employees/{userId}/sentShuttles/{shuttleId}")
    .onCreate(async (change, context) => {
      const reqVal = change.val();

      switch (reqVal) {
        case request.pending: // pending
        {
          const userId = context.params.userId;
          const shuttleId = context.params.shuttleId;
          return (await admin.database()
              .ref(`/shuttles/${shuttleId}/pendingEmployees/${userId}`)
              .set(reqVal));
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.sentShuttleEmployeeRequestUpdate = functions.database
    .ref("/employees/{userId}/sentShuttles/{shuttleId}")
    .onUpdate(async (change, context) => {
      const reqVal = change.after.val();

      switch (reqVal) {
        case request.canceled: // canceled
        {
          const userId = context.params.userId;
          const shuttleId = context.params.shuttleId;
          const responses = [];
          responses.push(await change.after.ref.remove());
          responses.push(await admin.database()
              .ref(`/shuttles/${shuttleId}/pendingEmployees/${userId}`)
              .remove());
          return responses;
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.sentConnectionRequestCreate = functions.database
    .ref("/users/{fromId}/sentUsers/{toId}")
    .onCreate(async (change, context) => {
      const reqVal = change.val();

      switch (reqVal) {
        case request.pending: // pending
        {
          const toId = context.params.toId;
          const fromId = context.params.fromId;
          const realToId = (await admin.database()
              .ref(`/publicUserIds/${toId}`).once("value")).val();
          return (await admin.database()
              .ref(`/users/${realToId}/pendingUsers/${fromId}`)
              .set(reqVal));
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.sentConnectionRequestUpdate = functions.database
    .ref("/users/{fromId}/sentUsers/{toId}")
    .onUpdate(async (change, context) => {
      const reqVal = change.after.val();

      switch (reqVal) {
        case request.canceled: // canceled
        {
          const toId = context.params.toId;
          const fromId = context.params.fromId;
          const realToId = (await admin.database()
              .ref(`/publicUserIds/${toId}`).once("value")).val();
          const responses = [];
          responses.push(await change.after.ref.remove());
          responses.push(await admin.database()
              .ref(`/users/${realToId}/pendingUsers/${fromId}`)
              .remove());
          return responses;
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.sentRouteSubRequestCreate = functions.database
    .ref("/users/{userId}/sentRoutes/{routeId}")
    .onCreate(async (change, context) => {
      const reqVal = change.val();

      switch (reqVal) {
        case request.pending: // pending
        {
          const userId = context.params.userId;
          const routeId = context.params.routeId;

          return (await admin.database()
              .ref(`/routes/${routeId}/pendingUsers/${userId}`)
              .set(request.pending));
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.sentRouteSubRequestUpdate = functions.database
    .ref("/users/{userId}/sentRoutes/{routeId}")
    .onUpdate(async (change, context) => {
      const reqVal = change.after.val();

      switch (reqVal) {
        case request.canceled: // canceled
        {
          const userId = context.params.userId;
          const routeId = context.params.routeId;
          const responses = [];
          responses.push(await change.after.ref.remove());
          responses.push(await admin.database()
              .ref(`/routes/${routeId}/pendingUsers/${userId}`)
              .remove());
          return responses;
        }
        default:
          return functions.logger
              .log("Unexpected request value:", reqVal);
      }
    });

exports.onShuttleDisown = functions.database
    .ref("/shuttles/{shuttleId}/employees")
    .onDelete(async (change, context) => {
      const shuttleData = (await change.ref.parent!.once("value")).val();
      admin.database().ref(`/plates/${shuttleData.plate}`).remove();
      change.ref.parent?.remove();
      if (shuttleData.routes != null) {
        const routes = Object.keys(shuttleData.routes);
        routes.forEach((routeId, index) => {
          admin.database().ref(`/routes/${routeId}`).remove();
        });
      }
    });

exports.onChildDisown = functions.database
    .ref("/users/{childId}/parents")
    .onDelete(async (change, context) => {
      if (!((await change.ref.parent!.once("value")).val().isReal)) {
        change.ref.parent?.remove();
      }
    });
