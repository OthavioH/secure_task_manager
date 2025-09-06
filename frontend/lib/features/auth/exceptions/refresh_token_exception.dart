
class RefreshTokenException implements Exception {
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