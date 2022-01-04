class UserUseRoute {
  final int value;

  const UserUseRoute._(this.value);

  /// User won't use shuttle
  static const negative = UserUseRoute._(0);

  /// User will use shuttle
  static const positive = UserUseRoute._(1);

  /// User will be late
  static const late = UserUseRoute._(2);
}
