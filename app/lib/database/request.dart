class Request {
  final int value;

  const Request._(this.value);

  static const reject = Request._(0);
  static const accept = Request._(1);
  static const pending = Request._(2);
  static const canceled = Request._(3);
}

extension RequestChecking on String {
  Request parseRequest() {
    try {
      return Request._(int.parse(this));
    } catch (e) {
      rethrow;
    }
  }
}
