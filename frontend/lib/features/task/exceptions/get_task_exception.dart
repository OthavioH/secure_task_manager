class GetTaskException implements Exception {
  const GetTaskException();

  factory GetTaskException.fromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => const GetTaskBadRequestException(),
      _ => const GetTaskException(),
    };
  }

  @override
  String toString() => 'An error occurred while reading tasks';
}

class GetTaskBadRequestException implements GetTaskException {
  const GetTaskBadRequestException();

  @override
  String toString() => 'The provided user is invalid';
}
