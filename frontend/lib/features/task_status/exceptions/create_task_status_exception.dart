class CreateTaskStatusException implements Exception {
  const CreateTaskStatusException();

  factory CreateTaskStatusException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => const CreateTaskStatusBadRequestException(),
      409 => const CreateTaskStatusConflictException(),
      _ => const CreateTaskStatusException(),
    };
  }

  @override
  String toString() => 'An error occurred while creating the task status';
}

class CreateTaskStatusBadRequestException implements CreateTaskStatusException {
  const CreateTaskStatusBadRequestException();

  @override
  String toString() => 'The provided name or user is invalid';
}

class CreateTaskStatusConflictException implements CreateTaskStatusException {
  const CreateTaskStatusConflictException();

  @override
  String toString() => 'This status already exists';
}
