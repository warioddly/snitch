


class Failure {

  final Object? message;
  final StackTrace? stackTrace;

  const Failure(this.message, [this.stackTrace]);

  @override
  String toString() => '''
    Failure: $message
    StackTrace: $stackTrace
  ''';
}
