
class LoginException implements Exception {

  const LoginException();

  factory LoginException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => LoginBadRequestException(),
      401 => LoginWrongCredentialsException(),
      _ => const LoginException(),
    };
  }

  @override
  String toString() {
    return "Got an unknown error while trying to authenticate";
  }
}

class LoginWrongCredentialsException extends LoginException {
  @override
  String toString() {
    return "Your username or password are incorrect.";
  }
}

class LoginBadRequestException extends LoginException {
  
  @override
  String toString() {
    return "Valid username and password must be provided.";
  }
}