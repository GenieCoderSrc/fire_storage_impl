import 'dart:io';
import 'dart:typed_data';

abstract class IFireStorageService {
  Future<String?> uploadFile({
    final File? file,
    final Uint8List? bytes,
    final String? fileName,
    final String? collectionPath = '',
    final String? uploadingToastTxt,
    final String fileType = 'Images',
  });

  Future<bool> deleteFile({required String imgUrl, String? successTxt});
}
