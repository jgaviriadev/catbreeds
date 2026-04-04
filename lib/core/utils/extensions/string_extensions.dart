/// Useful nullable String extensions.
extension NullableStringExtensions on String? {
  /// Checks if the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
