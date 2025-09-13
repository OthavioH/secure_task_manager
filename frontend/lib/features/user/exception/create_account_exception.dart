

class CreateAccountException implements Exception {

  const CreateAccountException();

  factory CreateAccountException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => InvalidValuesException(),
      409 => UserAlreadyExistsException(),
      _ => const CreateAccountException(),
    };
  }

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

class InvalidValuesException implements CreateAccountException {

  @override
  String toString() {
    return "Please, fill all fields correctly";
  }
}
