class Result<L, R> {
  final L? failure;
  final R? success;

  Result({this.failure, this.success});

  bool hasException() => failure != null;
  bool hasSuccess() => success != null;

  void fold(void Function(L e) onException, void Function(R s) onSuccess) {
    if (hasException()) {
      return onException(failure as L);
    } else if (hasSuccess()) {
      return onSuccess(success as R);
    }

    throw Exception(
        'Invalid state: Result must have either an exception or success data.');
  }
}
