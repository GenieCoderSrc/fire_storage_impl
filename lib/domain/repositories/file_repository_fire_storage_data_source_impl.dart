import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:fire_storage_impl/data/data_sources/i_data_sources/i_fire_storage_service.dart';
import 'package:fire_storage_impl/domain/entities/file_entity.dart';
import 'package:flutter/foundation.dart';

import 'i_repositories/i_file_repository.dart';


class FileRepositoryFireStorageDataSourceImpl extends IFileRepository {
  final IFireStorageService iFireStorageService;

  FileRepositoryFireStorageDataSourceImpl({required this.iFireStorageService});

  @override
  Future<Either<IFailure, bool>> deleteFile(String imgUrl) async {
    try {
      bool isDeleted = await iFireStorageService.deleteFile(imgUrl: imgUrl);

      return Right<IFailure, bool>(isDeleted);
    } catch (e) {
      debugPrint(
          'FileRepositoryFireStorageDataSourceImpl | deleteFile | error: $e');
      return const Left<FireStorageFailure, bool>(
          FireStorageFailure(FireStorageFailureType.dataParsingFailure));
    }
  }

  @override
  Future<Either<IFailure, String>> uploadFile(FileEntity fileEntity) async {
    try {
      String? imgUrl = await iFireStorageService.uploadFile(
        fileEntity.file,
        fileName: fileEntity.fileName,
        collectionPath: fileEntity.path,
        fileType: fileEntity.fileType ?? 'Images',
        uploadingToastTxt: fileEntity.uploadingToastTxt,
      );
      if (imgUrl == null) {
        return const Left<FireStorageFailure, String>(
            FireStorageFailure(FireStorageFailureType.referenceNotFound));
      }
      return Right<IFailure, String>(imgUrl);
    } catch (e) {
      debugPrint(
          'FileRepositoryFireStorageDataSourceImpl | uploadFile | error: $e');
      return const Left<FireStorageFailure, String>(
          FireStorageFailure(FireStorageFailureType.dataParsingFailure));
    }
  }
}
