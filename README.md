# fire_storage_impl

A lightweight Dart/Flutter package for simplified Firebase Storage file uploading and deletion, supporting both mobile and web platforms. It includes toast notifications and localized error messages via a translator service.

## Features

- Upload image files (`File` or `Uint8List`) to Firebase Storage
- Delete uploaded files from Firebase Storage
- Toast message integration using `app_toast`
- Context-free localization support via `.translateWithoutContext()`
- Automatic file name generation when not provided

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  fire_storage_impl: <latest_version>
```

Then run:

```bash
flutter pub get
```

## Usage

### Upload a File (Mobile or Web)

```dart
final fireStorage = FireStorageServiceImpl();

String? downloadUrl = await fireStorage.uploadFile(
  file,
  fileName: 'example_image',
  collectionPath: 'user_uploads',
  uploadingToastTxt: 'Uploading...',
);
```

### Delete a File

```dart
bool success = await fireStorage.deleteFile(
  imgUrl: downloadUrl!,
  successTxt: 'Deleted successfully',
);
```

### Upload Uint8List (e.g. Web image picker)

```dart
final imageData = Uint8List.fromList([...]);

final downloadUrl = await imageData.uploadToFirebaseStorage(
  fileName: 'web_image.jpeg',
  collectionPath: 'web_uploads',
);
```

## File Model (Optional)

Use `FileModel` to pass file data in a structured format:

```dart
final fileModel = FileModel(
  file: file,
  fileName: 'my_image',
  fileType: 'Images',
  collectionPath: 'avatars',
  uploadingToastTxt: 'Uploading avatar...'
);
```

## Requirements

- Firebase Core & Firebase Storage setup
- Add `app_toast` and `translator` dependencies
- Internet permission (mobile)

## Dependencies

- firebase_storage
- app_toast
- translator (custom)

## License

This `README.md` provides installation instructions, basic usage examples, error handling, and additional features. Make sure to replace the version placeholder with the actual version number when you publish it on `pub.dev`.

---

Made with by Shohidul Islam / GenieCoder

