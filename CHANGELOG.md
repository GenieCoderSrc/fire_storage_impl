# Changelog


## 0.0.5+1
- Update dependencies.

## 0.0.5
- Remove This Files.
  - file_register_get_it_di_fire_storage_data_source.
  - file_use_cases_register_get_it_di.
  - file_di_const_rest_api_data_source.
  - file_di_const_fire_storage_data_source.
  - file_model.
  - file_entity.
  - file_response_entity.
  - file_repository_fire_storage_data_source_impl.
  - i_file_repository.
  - delete_file.
  - upload_file.
  - i_delete_file.
  - i_upload_file.
  - image_uploader.

## 0.0.4
- Created file UseCases Register GetIt DI.

## 0.0.3
- Created fileRegisterGetItDIFireStorageDataSource.

## 0.0.2
- Implemented Repository.
- Implemented Use cases.
- Implemented Entity.
- Registered with Get It Dependency Injection.

## 0.0.1
- Initial release of `fire_storage_impl`.
- Added support for uploading files to Firebase Storage from mobile and web.
- Included toast notification support using `app_toast`.
- Basic localization support with `.translateWithoutContext()`.
- Provided method for deleting files from Firebase Storage.
- Included extension method for automatic file name generation.
- Added `Uint8List` extension for image uploading (for web compatibility).
- Includes `FileModel` for structured file handling.

