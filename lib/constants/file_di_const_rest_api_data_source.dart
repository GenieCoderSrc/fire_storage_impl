import 'i_constants/i_file_di_const.dart';

class FileDiConstRestApiDataSource implements IFileDiConst {
  @override
  String getFileInstance() => 'Rest_Api_File_Instance';

  @override
  String getUploadInstance() => 'Rest_Api_Upload_Instance';

  @override
  String getDeleteInstance() => 'Rest_Api_Delete_Instance';

  @override
  String getImageFieldCubitInstance() => 'Image_Field_Cubit_Rest_Api_Instance';
}
