import 'package:fire_storage_impl/typedefs/progress_callback.dart';
import 'package:image_core/image_core.dart';

abstract class IFireStorageService {
  Future<String?> uploadFile({
    required UploadFile uploadFile,
    ProgressCallback? onProgress,
  });

  Future<bool> deleteFile({required String imgUrl, String? successTxt});
}
