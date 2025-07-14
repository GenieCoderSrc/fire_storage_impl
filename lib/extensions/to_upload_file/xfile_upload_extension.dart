// 📄 xfile_upload_extension.dart

import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:fire_storage_impl/data/models/upload_file.dart';
import 'package:fire_storage_impl/utils/file_category_resolver.dart';
import 'package:mime/mime.dart';

extension XFileToUploadFile on XFile {
  Future<UploadFile> toUploadFile({
    String? fileName,
    String? collectionPath,
    String? uploadingToastTxt,
    Map<String, String>? metadata,
    String? contentDisposition,
  }) async {
    final Uint8List bytes = await readAsBytes();
    final String resolvedName = fileName ?? name;
    final String mimeType =
        this.mimeType ??
        lookupMimeType(resolvedName) ??
        'application/octet-stream';
    final category = FileCategoryResolver.fromMimeType(mimeType);

    return UploadFile(
      bytes: bytes,
      name: resolvedName,
      mimeType: mimeType,
      collectionPath: collectionPath,
      uploadingToastTxt: uploadingToastTxt,
      metadata: metadata ?? {'source': 'xfile', 'file-path': path},
      contentDisposition: contentDisposition,
      category: category,
    );
  }
}
