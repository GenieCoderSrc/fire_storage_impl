import 'dart:typed_data';

import 'package:fire_storage_impl/data/enums/file_category.dart';

class UploadFile {
  final Uint8List bytes;
  final String? name;
  final String? mimeType;
  final String? collectionPath;
  final String? uploadingToastTxt;
  final Map<String, String>? metadata;
  final String? contentDisposition;
  final FileCategory category;

  UploadFile({
    required this.bytes,
    this.name,
    this.mimeType,
    this.collectionPath,
    this.uploadingToastTxt,
    this.metadata,
    this.contentDisposition,
    this.category = FileCategory.other,
  });
}
