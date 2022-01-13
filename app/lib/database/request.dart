class Request {
  final int value;

  const Request._(this.value);

  static const reject = Request._(0);
  static const accept = Request._(1);
  static const pending = Request._(2);
  static const canceled = Request._(3);

  @override
  bool operator ==(dynamic other) =>
      (other is String && value.toString() == other) ||
      (other is int && value == other) ||
      (other is Request && value == other.value);
}
