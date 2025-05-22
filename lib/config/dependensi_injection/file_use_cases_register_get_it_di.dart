import 'package:fire_storage_impl/domain/usecases/delete_file.dart';
import 'package:fire_storage_impl/domain/usecases/upload_file.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';


void fileUseCasesRegisterGetItDI() {
  /// ----------------- File Get It DI register ------------------
  // use cases
  sl.registerLazySingleton(() => UploadFile(sl()));
  sl.registerLazySingleton(() => DeleteFile(sl()));
}

