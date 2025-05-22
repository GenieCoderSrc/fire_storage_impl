import 'package:equatable/equatable.dart';

class FileResponseEntity extends Equatable {
  final String? fileName;
  final String? imgUrl;

  const FileResponseEntity({this.fileName, this.imgUrl});

  FileResponseEntity copyWith({String? fileName, String? imgUrl}) =>
      FileResponseEntity(
          fileName: fileName ?? this.fileName, imgUrl: imgUrl ?? this.imgUrl);

  @override
  List<Object?> get props => [fileName, imgUrl];

  Map<String, dynamic> toJson() => {'fileName': fileName, 'imgUrl': imgUrl};
}
