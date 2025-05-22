import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';

abstract class IDeleteFile extends IEitherUseCase<bool, String> {
  @override
  Future<Either<IFailure, bool>> call(String params);
}
