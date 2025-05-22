import 'dart:io';

import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final File file;

  final String? path;
  final String? fileName;
  final String? fileType;
  final String? uploadingToastTxt;

  const FileEntity({
    required this.file,
    this.fileName,
    this.path,
    this.fileType = 'Images',
    this.uploadingToastTxt,
  });

  FileEntity copyWith({
    File? file,
    String? collectionPath,
    String? fileName,
    String? fileType,
    String? uploadingToastTxt,
  }) =>
      FileEntity(
        file: file ?? this.file,
        path: collectionPath ?? path,
        fileName: fileName ?? this.fileName,
        fileType: fileType ?? this.fileType,
        uploadingToastTxt: uploadingToastTxt ?? this.uploadingToastTxt,
      );

  @override
  List<Object?> get props =>
      [file, path, fileName, fileType, uploadingToastTxt];

  Map<String, dynamic> toJson() => {
        'file': file,
        'path': path,
        'fileName': fileName,
        'fileType': fileType,
        'uploadingToastTxt': uploadingToastTxt,
      };
}
