import 'dart:io';

class FileModel {
  final File? file;
  final String? fileName;
  final String? fileType;
  final String? collectionPath;
  final String? uploadingToastTxt;

  FileModel({
    this.file,
    this.fileName,
    this.fileType,
    this.collectionPath,
    this.uploadingToastTxt,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      file: json['file'] != null ? File(json['file']) : null,
      fileName: json['fileName'],
      fileType: json['fileType'],
      collectionPath: json['collectionPath'],
      uploadingToastTxt: json['uploadingToastTxt'],
    );
  }
}
