import 'package:cross_file/cross_file.dart';
import 'package:fire_storage_impl/typedefs/progress_callback.dart';
import 'package:image_core/image_core.dart';

abstract class IFireStorageService {
  Future<String?> uploadFile({
    required final XFile file,
    final String? fileName,
    final String? category,
    final String? collectionPath,
    final Map<String, String>? metadata,
    final String? contentDisposition,
    final String? uploadingToastTxt,
    final ProgressCallback? onProgress,
  });

  Future<bool> deleteFile({required String fileUrl, String? successTxt});
}
