class BaseError extends Error {
  final String? message;
  final int? code;

  BaseError(this.message, [this.code]);
}