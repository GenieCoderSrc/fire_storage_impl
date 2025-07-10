import 'package:fire_storage_impl/data/models/upload_file.dart';
import 'package:fire_storage_impl/typedefs/progress_callback.dart';

abstract class IFireStorageService {
  Future<String?> uploadFile({
    required UploadFile uploadFile,
    ProgressCallback? onProgress,
  });

  Future<bool> deleteFile({required String imgUrl, String? successTxt});
}
