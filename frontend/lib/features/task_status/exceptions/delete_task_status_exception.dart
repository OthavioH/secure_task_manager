class DeleteTaskStatusException implements Exception {
  const DeleteTaskStatusException();

  factory DeleteTaskStatusException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      409 => const DeleteTaskStatusInUseException(),
      400 => const DeleteTaskStatusBadRequestException(),
      404 => const DeleteTaskStatusNotFoundException(),
      _ => const DeleteTaskStatusException(),
    };
  }

  @override
  String toString() => 'An error occurred while deleting the task status';
}

class DeleteTaskStatusBadRequestException implements DeleteTaskStatusException {
  const DeleteTaskStatusBadRequestException();

  @override
  String toString() => 'The provided status has invalid data';
}

class DeleteTaskStatusNotFoundException implements DeleteTaskStatusException {
  const DeleteTaskStatusNotFoundException();

  @override
  String toString() => 'The status was not found';
}

class DeleteTaskStatusInUseException implements DeleteTaskStatusException {
  const DeleteTaskStatusInUseException();

  @override
  String toString() => 'The status is in use and cannot be deleted. First, delete or update all tasks associated with this status.';
}
