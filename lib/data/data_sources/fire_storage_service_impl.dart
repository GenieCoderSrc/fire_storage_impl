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

  /// The user selects a file, and the task is added to the list.
  @override
  Future<String?> uploadFile(
    final File? file, {
    final String? fileName,
    final String? collectionPath,
    final String? uploadingToastTxt,
    final String fileType = 'Images',
  }) async {
    try {
      if (file == null) {
        AppToast.showToast(msg: FireStorageTxtConst.fileNotSelected);
        return null;
      }

      // set file name
      final String fileName0 = fileName.getFileName();
      final String extension = file.path.split('.').last;

      // UploadTask uploadTask;
      TaskSnapshot uploadTask;

      // Create a Reference to the file
      final Reference ref = _storage
          .ref()
          .child(fileType)
          .child('/$collectionPath/$fileName0.$extension');

      final SettableMetadata metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: <String, String>{'picked-file-path': file.path});

      if (uploadingToastTxt != null && uploadingToastTxt.isNotEmpty) {
        AppToast.showToast(msg: uploadingToastTxt.trim());
      }

      if (kIsWeb) {
        uploadTask = await ref.putData(await file.readAsBytes(), metadata);
      } else {
        uploadTask = await ref.putFile(file, metadata);
      }
      final String imageUrl = await uploadTask.ref.getDownloadURL();

      debugPrint('FireStorageServiceImpl | uploadFile | imageUrl: $imageUrl');

      return imageUrl;
    } on PlatformException catch (e) {
      String errorMsg = FireStorageTxtConst.failedToUpload;

      debugPrint('Firebase Upload file error: $e');
      if (e.code == 'unauthorized') {
        errorMsg = FireStorageTxtConst.fileMustBeLessThan5Mb;
      } else if (e.code == 'unknown') {
        errorMsg = FireStorageTxtConst.internetConnectionFailed;
      }
      AppToast.showToast(msg: errorMsg);
      return null;
    } catch (e) {
      debugPrint('Firebase Upload file error: $e');
      return null;
    }
  }

  @override
  Future<bool> deleteFile({required String imgUrl, String? successTxt}) async {
    try {
      if (imgUrl.isNotEmpty) {
        final Reference ref = _storage.refFromURL(imgUrl);
        await ref.delete();
        debugPrint('Image has been successfully deleted: $imgUrl');
        if (successTxt != null) {
          AppToast.showToast(msg: successTxt);
        }
        return true;
      }
      return false;
    } catch (error) {
      debugPrint('Error deleting image: $error');
      return false;
    }
  }
}
