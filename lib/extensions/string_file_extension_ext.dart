extension FileExtensionExtractor on String? {
  /// Returns the file extension (e.g., "jpg") from a filename or path.
  /// Returns `null` if the extension is not present.
  String? getFileExtension() {
    if (this == null || !this!.contains('.')) return null;
    return this!.split('.').last;
  }
}
