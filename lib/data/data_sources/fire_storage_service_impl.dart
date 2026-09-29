import 'package:app_toast/app_toast.dart';
import 'package:cross_file/cross_file.dart';
import 'package:fire_storage_impl/extensions/file_name_generator.dart';
import 'package:fire_storage_impl/extensions/path_extensions.dart';
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
    required final XFile file,
    final String? fileName,
    final String? category,
    final String? collectionPath,
    final Map<String, String>? metadata,
    final String? contentDisposition,
    final String? uploadingToastTxt,
    final ProgressCallback? onProgress,
  }) async {
    try {
      final Uint8List bytes = await file.readAsBytes();

      final String baseName = fileName ?? file.name.getFileName();
      final String ext = file.name.getFileExtension() ?? 'bin';
      final String fullName = '$baseName.$ext';

      // ✅ Safe path building using extension
      final String fullPath = [
        category,
        collectionPath,
        fullName,
      ].buildStoragePath();
      final String contentType = ContentTypeUtil.resolve(ext);

      final Map<String, String> finalMetadata = {
        'original-name': file.name,
        if (metadata != null) ...metadata,
      };

      final SettableMetadata storageMetadata = SettableMetadata(
        contentType: contentType,
        customMetadata: finalMetadata.isEmpty ? null : finalMetadata,
        contentDisposition: contentDisposition,
      );

      final Reference ref = _storage.ref().child(fullPath);

      if (uploadingToastTxt?.trim().isNotEmpty == true) {
        AppToast.showToast(msg: uploadingToastTxt!.trim());
      }

      final UploadTask task = ref.putData(bytes, storageMetadata);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.totalBytes > 0
            ? snapshot.bytesTransferred / snapshot.totalBytes
            : 0.0;
        onProgress?.call(progress);
      });

      final snapshot = await task;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('uploadFile | downloadUrl: $downloadUrl');
      return downloadUrl;
    } on PlatformException catch (e) {
      return FirebasePlatformExceptionHandler.handleUploadError(e);
    } catch (e) {
      debugPrint('uploadFile error: $e');
      return null;
    }
  }

  @override
  Future<bool> deleteFile({required String fileUrl, String? successTxt}) async {
    try {
      if (fileUrl.isEmpty) return false;
      final ref = _storage.refFromURL(fileUrl);
      await ref.delete();
      debugPrint('Deleted: $fileUrl');
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
