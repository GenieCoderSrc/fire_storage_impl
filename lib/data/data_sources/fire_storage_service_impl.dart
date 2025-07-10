import 'package:app_toast/app_toast.dart';
import 'package:fire_storage_impl/data/models/upload_file.dart';
import 'package:fire_storage_impl/extensions/file_name_generator.dart';
import 'package:fire_storage_impl/extensions/string_file_extension_ext.dart';
import 'package:fire_storage_impl/typedefs/progress_callback.dart';
import 'package:fire_storage_impl/utils/content_type_util.dart';
import 'package:fire_storage_impl/utils/firebase_platform_exception_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'i_data_sources/i_fire_storage_service.dart';

class FireStorageServiceImpl extends IFireStorageService {
  final FirebaseStorage _storage;

  FireStorageServiceImpl({FirebaseStorage? fireStorage})
    : _storage = fireStorage ?? FirebaseStorage.instance;

  @override
  Future<String?> uploadFile({
    required UploadFile uploadFile,
    ProgressCallback? onProgress,
  }) async {
    try {
      final Uint8List bytes = uploadFile.bytes;
      final String baseName =
          uploadFile.name?.getFileName() ??
          'file_${DateTime.now().millisecondsSinceEpoch}';
      final String ext = uploadFile.name?.getFileExtension() ?? 'bin';
      final String fullName = '$baseName.$ext';

      final String categoryPath =
          uploadFile.category.name; // e.g., 'image', 'video'
      final String collectionPath = uploadFile.collectionPath?.trim() ?? '';
      final String fullPath = '$categoryPath/$collectionPath/$fullName';

      final String contentType =
          uploadFile.mimeType ?? ContentTypeUtil.resolve(ext);

      final Map<String, String> finalMetadata = {
        if (uploadFile.name != null) 'original-name': uploadFile.name!,
        if (uploadFile.metadata != null) ...uploadFile.metadata!,
      };

      final SettableMetadata metadata = SettableMetadata(
        contentType: contentType,
        customMetadata: finalMetadata.isEmpty ? null : finalMetadata,
        contentDisposition: uploadFile.contentDisposition,
      );

      final Reference ref = _storage.ref().child(fullPath);

      if (uploadFile.uploadingToastTxt?.trim().isNotEmpty == true) {
        AppToast.showToast(msg: uploadFile.uploadingToastTxt!.trim());
      }

      final UploadTask task = ref.putData(bytes, metadata);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.totalBytes > 0
            ? snapshot.bytesTransferred / snapshot.totalBytes
            : 0.0;
        onProgress?.call(progress);
      });

      final snapshot = await task;
      final imageUrl = await snapshot.ref.getDownloadURL();

      debugPrint('uploadFile | imageUrl: $imageUrl');
      return imageUrl;
    } on PlatformException catch (e) {
      return FirebasePlatformExceptionHandler.handleUploadError(e);
    } catch (e) {
      debugPrint('uploadFile error: $e');
      return null;
    }
  }

  @override
  Future<bool> deleteFile({required String imgUrl, String? successTxt}) async {
    try {
      if (imgUrl.isEmpty) return false;
      final ref = _storage.refFromURL(imgUrl);
      await ref.delete();
      debugPrint('Deleted: $imgUrl');
      if (successTxt != null) {
        AppToast.showToast(msg: successTxt);
      }
      return true;
    } catch (e) {
      debugPrint('Delete error: $e');
      return false;
    }
  }
}
