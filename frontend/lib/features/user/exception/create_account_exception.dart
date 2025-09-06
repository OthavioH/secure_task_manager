

class CreateAccountException implements Exception {

  @override
  String toString() {
    return "Unknown error while trying to creating account";
  }
}

class UserAlreadyExistsException implements CreateAccountException {
    
  @override
  String toString() {
    return "User already exists";
  }
}
