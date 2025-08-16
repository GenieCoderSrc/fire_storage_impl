extension FileNameGenerator on String? {
  String getFileName() {
    return this != null && this!.trim().isNotEmpty
        ? this!
        : 'file_${DateTime.now().millisecondsSinceEpoch}';
  }
}