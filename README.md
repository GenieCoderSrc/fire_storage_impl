# fire_storage_impl

A lightweight Dart/Flutter package for simplified Firebase Storage file uploading and deletion, supporting both mobile and web platforms. It includes toast notifications and localized error messages via a translator service.

## Features

* Upload files with [`XFile`](https://pub.dev/packages/cross_file) (cross‑platform)
* Delete uploaded files from Firebase Storage
* Toast message integration using `app_toast`
* Context-free localization support via `.translateWithoutContext()`
* Automatic file name generation when not provided
* Upload progress tracking via `onProgress` callback
* Safe storage path building with `StoragePathExtensions`

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

### Upload a File with `XFile`

```dart
final fireStorage = FireStorageServiceImpl();

final file = XFile('/path/to/image.jpg');

final url = await fireStorage.uploadFile(
  file: file,
  category: 'images',
  collectionPath: 'user_uploads',
  onProgress: (progress) {
    print('Upload progress: $progress');
  },
);
```

### Delete a File

```dart
final success = await fireStorage.deleteFile(
  imgUrl: url!,
  successTxt: 'Deleted successfully!',
);
```

### Build Safe Storage Path

```dart
final fullPath = StoragePathExtensions.buildStoragePath(
  category: 'images',
  collectionPath: 'profile_pics',
  fullName: 'avatar.png',
);
```

## Requirements

* Firebase Core & Firebase Storage setup
* Add `app_toast` and `translator` dependencies
* Internet permission (mobile)

## Dependencies

* firebase_storage
* cross_file
* app_toast
* translator (custom)

## License

This `README.md` provides installation instructions, basic usage examples, error handling, and additional features. Make sure to replace the version placeholder with the actual version number when you publish it on `pub.dev`.

---

Developed and Maintained with ❤️ by [Shohidul Islam / GenieCoder](https://github.com/ShohidulProgrammer). Contributions welcome!
