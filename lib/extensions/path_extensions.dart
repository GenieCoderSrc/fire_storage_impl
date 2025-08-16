extension StoragePathExtensions on List<String?> {
  /// Builds a safe Firebase Storage path by:
  /// - Trimming each segment
  /// - Skipping null or empty segments
  /// - Joining with `/`
  String buildStoragePath() {
    final filtered = where((s) => s?.trim().isNotEmpty == true)
        .map((s) => s!.trim())
        .toList();
    return filtered.join('/');
  }
}
