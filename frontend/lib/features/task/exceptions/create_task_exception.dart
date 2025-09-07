class CreateTaskException implements Exception {

  const CreateTaskException();

  factory CreateTaskException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => const CreateTaskBadRequestException(),
      _ => const CreateTaskException(),
    };
  }

  @override
  String toString() => 'Got an error while creating a task';
}

class CreateTaskBadRequestException implements CreateTaskException {
  const CreateTaskBadRequestException();

  @override
  String toString() =>
      'UserId, title, description and statusId are required and cannot be empty';
}
