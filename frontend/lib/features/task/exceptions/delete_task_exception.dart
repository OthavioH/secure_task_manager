class DeleteTaskException implements Exception {
  const DeleteTaskException();

  factory DeleteTaskException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => const DeleteTaskBadRequestException(),
      404 => const DeleteTaskNotFoundException(),
      _ => const DeleteTaskException(),
    };
  }

  @override
  String toString() => 'An error occurred while deleting the task';
}

class DeleteTaskBadRequestException implements DeleteTaskException {
  const DeleteTaskBadRequestException();

  @override
  String toString() => 'The provided task is invalid';
}

class DeleteTaskNotFoundException implements DeleteTaskException {
  const DeleteTaskNotFoundException();

  @override
  String toString() => 'The task was not found';
}
