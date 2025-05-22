import 'package:fire_storage_impl/data/data_sources/fire_storage_service_impl.dart';
import 'package:fire_storage_impl/data/data_sources/i_data_sources/i_fire_storage_service.dart';
import 'package:fire_storage_impl/domain/repositories/file_repository_fire_storage_data_source_impl.dart';
import 'package:fire_storage_impl/domain/repositories/i_repositories/i_file_repository.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';


void fileRegisterGetItDIFireStorageDataSource() {
  // Services
  sl.registerLazySingleton<IFireStorageService>(() => FireStorageServiceImpl());

  // Repositories
  sl.registerLazySingleton<IFileRepository>(
      () => FileRepositoryFireStorageDataSourceImpl(iFireStorageService: sl()));
}
