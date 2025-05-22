import 'i_constants/i_file_di_const.dart';

class FileDiConstFireStorageDataSource implements IFileDiConst {
  @override
  String getFileInstance() => 'Fire_Storage_File_Instance';

  @override
  String getUploadInstance() => 'Fire_Storage_Upload_Instance';

  @override
  String getDeleteInstance() => 'Fire_Storage_Delete_Instance';

  @override
  String getImageFieldCubitInstance() =>
      'Image_Field_Cubit_Fire_Storage_Instance';
}
