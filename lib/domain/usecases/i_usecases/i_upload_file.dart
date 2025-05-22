import 'package:dartz/dartz.dart';
import 'package:fire_storage_impl/domain/entities/file_entity.dart';
import 'package:fire_storage_impl/domain/entities/file_response_entity.dart';
import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';

abstract class IUploadFile
    extends IEitherUseCase<FileResponseEntity, FileEntity> {
  @override
  Future<Either<IFailure, FileResponseEntity>> call(FileEntity params);
}
