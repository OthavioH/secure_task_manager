
class RefreshTokenException implements Exception {

  const RefreshTokenException();

  factory RefreshTokenException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      401 => InvalidRefreshTokenException(),
      _ => const RefreshTokenException(),
    };
  }

  @override
  String toString() {
    return "Got an unknown error while trying to refresh token";
  }
}

class InvalidRefreshTokenException extends RefreshTokenException {
  @override
  String toString() {
    return "Refresh token is invalid";
  }
}