enum AppError {
  alreadyExists,
}

class AppException implements Exception {
  AppError err;
  String msg;
  AppException({required this.err, required this.msg});

  @override
  String toString() {
    return '${err.name}Exception: $msg.';
  }
}
