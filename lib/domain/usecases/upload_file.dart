import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:fire_storage_impl/domain/entities/file_entity.dart';
import 'package:fire_storage_impl/domain/repositories/i_repositories/i_file_repository.dart';
import 'package:i_tdd/i_tdd.dart';


class UploadFile extends IEitherUseCase<String, FileEntity> {
  final IFileRepository _iFileRepository;

  UploadFile(this._iFileRepository);

  @override
  Future<Either<IFailure, String>> call(FileEntity params) async =>
      _iFileRepository.uploadFile(params);
}

// class UploadFileFireStoreDataSourceImpl implements IUploadFile {
//   final IFileRepository _iFileRepository;
//
//   UploadFileFireStoreDataSourceImpl(this._iFileRepository);
//
//   @override
//   Future<Either<IFailure, String>> call(FileEntity params) async =>
//       _iFileRepository.uploadFile(params);
// }
