import 'dart:io';

abstract class IFireStorageService {
  Future<String?> uploadFile(File? file,
      {String? collectionPath = '',
      String? fileName = '',
      String fileType = 'Images',
      String? uploadingToastTxt});

  Future<bool> deleteFile({required String imgUrl, String? successTxt});
}
