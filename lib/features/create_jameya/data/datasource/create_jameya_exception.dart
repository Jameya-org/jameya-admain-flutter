/// A user-facing error raised by the create-jameya data source.
/// Its [toString] returns only the message so callers can show it directly.
class CreateJameyaException implements Exception {
  final String message;

  const CreateJameyaException(this.message);

  @override
  String toString() => message;
}
