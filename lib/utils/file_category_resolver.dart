import 'package:fire_storage_impl/data/enums/file_category.dart';

class FileCategoryResolver {
  static FileCategory fromMimeType(String? mimeType) {
    if (mimeType == null) return FileCategory.other;
    if (mimeType.startsWith('image/')) return FileCategory.image;
    if (mimeType.startsWith('video/')) return FileCategory.video;
    if (mimeType.startsWith('audio/')) return FileCategory.audio;
    if (mimeType == 'application/pdf' || mimeType.startsWith('application/')) {
      return FileCategory.document;
    }
    return FileCategory.other;
  }
}
