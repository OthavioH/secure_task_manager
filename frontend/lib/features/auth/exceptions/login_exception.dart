
class LoginException implements Exception {
  @override
  String toString() {
    return "Got an unknown error while trying to authenticate";
  }
}

class WrongCredentialsLoginException extends LoginException {
  @override
  String toString() {
    return "Your username or password are incorrect.";
  }
}