class GetTaskStatusException implements Exception {
  const GetTaskStatusException();

  factory GetTaskStatusException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => const GetTaskStatusBadRequestException(),
      _ => const GetTaskStatusException(),
    };
  }

  @override
  String toString() => 'An error occurred while reading task statuses';
}

class GetTaskStatusBadRequestException implements GetTaskStatusException {
  const GetTaskStatusBadRequestException();

  @override
  String toString() => 'The provided user is invalid';
}
