/// Extension for null safety and string manipulation
extension StringExtension on String? {
  /// Return empty string if null
  String orEmpty() => this ?? '';

  /// Check if string is empty or null
  bool get isEmpty => this == null || this!.isEmpty;

  /// Check if string is not empty
  bool get isNotEmpty => this != null && this!.isNotEmpty;
}

/// Extension for error handling
extension ErrorExtension on Object? {
  /// Convert error to readable message
  String toErrorMessage() {
    if (this is String) {
      return toString();
    }
    if (this is Exception) {
      return toString().replaceFirst('Exception: ', '');
    }
    return 'An unexpected error occurred';
  }
}
