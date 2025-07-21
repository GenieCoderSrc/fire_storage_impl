import 'dart:io';

import 'package:fire_storage_impl/fire_storage_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_core/extensions/to_upload_file/file_upload_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Make sure your firebase_options.dart is properly configured
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Storage Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const UploadDemoPage(),
    );
  }
}

class UploadDemoPage extends StatefulWidget {
  const UploadDemoPage({super.key});

  @override
  State<UploadDemoPage> createState() => _UploadDemoPageState();
}

class _UploadDemoPageState extends State<UploadDemoPage> {
  final FireStorageServiceImpl _storageService = FireStorageServiceImpl();

  String? _downloadUrl;
  double _uploadProgress = 0.0;

  Future<void> _uploadFile() async {
    const filePath = '/path/to/your/image.jpg';
    final file = File(filePath);

    if (!file.existsSync()) {
      _showMessage('File not found! Please update the path.');
      return;
    }

    final uploadFile = await file.toUploadFileFromFile(
      fileName: 'example_upload',
      collectionPath: 'demo_uploads',
      uploadingToastTxt: 'Uploading image...',
      metadata: {'demo-key': 'demo-value'},
    );

    // final uploadFile = await file.toUploadFile(
    //   fileName: 'example_upload',
    //   collectionPath: 'demo_uploads',
    //   uploadingToastTxt: 'Uploading image...',
    //   metadata: {'demo-key': 'demo-value'},
    // );

    if (uploadFile.bytes.isEmpty) {
      _showMessage('File is empty. Cannot upload.');
      return;
    }

    final url = await _storageService.uploadFile(
      uploadFile: uploadFile,
      onProgress: (progress) {
        setState(() => _uploadProgress = progress);
      },
    );

    if (url != null) {
      setState(() {
        _downloadUrl = url;
        _uploadProgress = 0.0;
      });
    } else {
      _showMessage('Upload failed.');
    }
  }

  Future<void> _deleteFile() async {
    if (_downloadUrl != null) {
      final success = await _storageService.deleteFile(
        imgUrl: _downloadUrl!,
        successTxt: 'Image deleted successfully!',
      );
      if (success) {
        setState(() {
          _downloadUrl = null;
          _uploadProgress = 0.0;
        });
      } else {
        _showMessage('Failed to delete the file.');
      }
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final progressPercent = (_uploadProgress * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(title: const Text('Fire Storage Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_downloadUrl != null)
              Image.network(_downloadUrl!, height: 200)
            else
              const Text('No image uploaded yet.'),
            const SizedBox(height: 20),
            if (_uploadProgress > 0 && _uploadProgress < 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(value: _uploadProgress),
                    const SizedBox(height: 8),
                    Text('Uploading: $progressPercent%'),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFile,
              child: const Text('Upload Local File'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteFile,
              child: const Text('Delete Uploaded File'),
            ),
          ],
        ),
      ),
    );
  }
}
