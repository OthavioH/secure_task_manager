class UpdateTaskStatusException implements Exception {
  const UpdateTaskStatusException();

  factory UpdateTaskStatusException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => const UpdateTaskStatusBadRequestException(),
      404 => const UpdateTaskStatusNotFoundException(),
      _ => const UpdateTaskStatusException(),
    };
  }

  @override
  String toString() => 'An error occurred while updating the task status';
}

class UpdateTaskStatusBadRequestException implements UpdateTaskStatusException {
  const UpdateTaskStatusBadRequestException();

  @override
  String toString() => 'The provided status has invalid data';
}

class UpdateTaskStatusNotFoundException implements UpdateTaskStatusException {
  const UpdateTaskStatusNotFoundException();

  @override
  String toString() => 'The status was not found';
}
