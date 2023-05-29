class RepositoryException implements Exception {
  final String message;

  RepositoryException({
    required this.message,
  });

  @override
  String toString() => 'RepositoryException(message: $message)';
}
