class UpdateTaskException implements Exception {
  const UpdateTaskException();

  factory UpdateTaskException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => const UpdateTaskBadRequestException(),
      404 => const UpdateTaskNotFoundException(),
      _ => const UpdateTaskException(),
    };
  }

  @override
  String toString() => 'An error occurred while updating the task';
}

class UpdateTaskBadRequestException implements UpdateTaskException {
  const UpdateTaskBadRequestException();

  @override
  String toString() => 'Id, title, description and statusId are required';
}

class UpdateTaskNotFoundException implements UpdateTaskException {
  const UpdateTaskNotFoundException();

  @override
  String toString() => 'The task was not found';
}

class UpdateTaskStatusNotFoundException implements UpdateTaskException {
  const UpdateTaskStatusNotFoundException();

  @override
  String toString() => 'The provided status was not found';
}