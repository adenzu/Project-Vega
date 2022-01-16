class NotificationType {
  final String value;

  const NotificationType._(this.value);

  static const connectionRequestReceive = "connectionRequestReceive";
  static const connectionRequestRespond = "connectionRequestRespond";
  static const employeeRequestReceive = "employeeRequestReceive";
  static const employeeRequestRespond = "employeeRequestRespond";
  static const routeSubRequestReceive = "routeSubRequestReceive";
  static const routeSubRequestRespond = "routeSubRequestRespond";
}
