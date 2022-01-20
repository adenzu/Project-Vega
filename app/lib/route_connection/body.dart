import 'package:app/database/functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RouteConnectionBody extends StatelessWidget {
  final userId;
  final routeIdFormKey = GlobalKey<FormState>();
  final routeIdController = TextEditingController();

  RouteConnectionBody({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: ListView(
          children: [
            Form(
              key: routeIdFormKey,
              child: TextFormField(
                controller: routeIdController,
                decoration: const InputDecoration(
                  label: Text("Rota kodu"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alan boş bırakılamaz";
                  } else if (!value.contains(RegExp(r'^R[0-9]+$'))) {
                    return "Uygun bir kod girin";
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (routeIdFormKey.currentState!.validate()) {
                    String routeId = routeIdController.text;
                    if (await checkRouteExists(routeId)) {
                      List<String>? userRoutes =
                          await getUserRoutes(userId: userId);

                      if (userRoutes!.contains(routeId)) {
                        Fluttertoast.showToast(
                            msg: "Bu rotaya halihazırda abone");
                      } else {
                        requestRouteSub(routeId, userId: userId);
                        Fluttertoast.showToast(msg: "Abone isteği yollandı");
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Bu kodla bir rota bulunmamakta");
                    }
                  }
                },
                child: const Text("Bağlan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
