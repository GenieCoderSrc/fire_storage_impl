import 'dart:io';

import 'package:app_toast/app_toast.dart';
import 'package:fire_storage_impl/constants/fire_storage_txt_const.dart';
import 'package:fire_storage_impl/extensions/file_name_generator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'i_data_sources/i_fire_storage_service.dart';

class FireStorageServiceImpl extends IFireStorageService {
  final FirebaseStorage _storage;

  FireStorageServiceImpl({FirebaseStorage? fireStorage})
    : _storage = fireStorage ?? FirebaseStorage.instance;

  /// Uploads to Firebase Storage using either [file] or [bytes].
  ///
  /// Throws if both are null. [bytes] takes priority over [file].
  @override
  Future<String?> uploadFile({
    final File? file,
    final Uint8List? bytes,
    final String? fileName,
    final String? collectionPath = '',
    final String? uploadingToastTxt,
    final String fileType = 'Images',
  }) async {
    try {
      // Enforce at least one non-null input
      final Uint8List resolvedBytes;
      if (bytes != null) {
        resolvedBytes = bytes;
      } else if (!kIsWeb && file != null) {
        resolvedBytes = await file.readAsBytes();
      } else {
        AppToast.showToast(msg: FireStorageTxtConst.fileNotSelected);
        return null;
      }

      // Extract extension from fileName
      final String extension = _getExtension(fileName) ?? 'jpg';
      final String baseName = fileName.getFileName();
      final String fullName = '$baseName.$extension';

      final Reference ref = _storage
          .ref()
          .child(fileType)
          .child('/$collectionPath/$fullName');

      final SettableMetadata metadata = SettableMetadata(
        contentType: _detectContentType(extension),
        customMetadata: {if (file != null) 'picked-file-path': file.path},
      );

      if (uploadingToastTxt?.trim().isNotEmpty == true) {
        AppToast.showToast(msg: uploadingToastTxt!.trim());
      }

      final uploadTask = await ref.putData(resolvedBytes, metadata);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      debugPrint('uploadFile | imageUrl: $imageUrl');
      return imageUrl;
    } on PlatformException catch (e) {
      return _handlePlatformException(e);
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

  String? _getExtension(String? pathOrName) {
    if (pathOrName == null || !pathOrName.contains('.')) return null;
    return pathOrName.split('.').last;
  }

  String _detectContentType(String ext) {
    switch (ext.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'pdf':
        return 'application/pdf';
      case 'mp4':
        return 'video/mp4';
      default:
        return 'application/octet-stream';
    }
  }

  String? _handlePlatformException(PlatformException e) {
    String msg = FireStorageTxtConst.failedToUpload;
    if (e.code == 'unauthorized') {
      msg = FireStorageTxtConst.fileMustBeLessThan5Mb;
    } else if (e.code == 'unknown') {
      msg = FireStorageTxtConst.internetConnectionFailed;
    }
    AppToast.showToast(msg: msg);
    debugPrint('PlatformException: $e');
    return null;
  }
}
