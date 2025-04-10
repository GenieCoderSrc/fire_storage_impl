extension FileNameGenerator on String? {
  String getFileName() {
    return this != null && this!.trim().isNotEmpty
        ? this!
        : DateTime.now().millisecondsSinceEpoch.toString();
  }
}
