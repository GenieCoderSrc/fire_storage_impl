import 'dart:typed_data';
import 'package:fire_storage_impl/extensions/file_name_generator.dart';
import 'package:firebase_storage/firebase_storage.dart';

extension ImageUploader on Uint8List {
  Future<String> uploadToFirebaseStorage({
    final String? fileName,
    final String? collectionPath,
    final String fileType = 'image',
  }) async {
    try {
      // await Firebase.initializeApp(); // Initialize Firebase (call this once in your app)

      // set file name
      final String fileName0 = fileName.getFileName();
      final String extension = fileName?.split('.').last ?? 'jpeg';

      // Create a Reference to the file
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child(fileType)
          .child('/$collectionPath/$fileName0.$extension');

      final SettableMetadata metadata = SettableMetadata(
          contentType: '$fileType/$extension',
          customMetadata: <String, String>{'picked-file-path': fileName.toString()});


      UploadTask uploadTask = storageReference.putData(this, metadata);

      await uploadTask.whenComplete(() => null);

      return await storageReference.getDownloadURL();
    } catch (e) {
      return 'Error uploading image to Firebase Storage: $e';
    }
  }
}
