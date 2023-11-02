class TokenAvailableException implements Exception {
  final String message;

  TokenAvailableException(this.message);

  @override
  String toString() {
    return 'TokenAvailableException: $message';
  }
}