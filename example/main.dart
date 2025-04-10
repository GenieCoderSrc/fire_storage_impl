
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fire_storage_impl/data/data_sources/fire_storage_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is properly configured
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Storage Example',
      theme: ThemeData(primarySwatch: Colors.blue),
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

  Future<void> _uploadFile() async {
    // Replace this with a valid local file path for testing
    final filePath = '/path/to/your/image.jpg';
    final file = File(filePath);

    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File not found! Please update the path.')),
      );
      return;
    }

    final url = await _storageService.uploadFile(
      file,
      fileName: 'example_upload',
      collectionPath: 'demos',
      uploadingToastTxt: 'Uploading image...',
    );

    if (url != null) {
      setState(() => _downloadUrl = url);
    }
  }

  Future<void> _deleteFile() async {
    if (_downloadUrl != null) {
      await _storageService.deleteFile(
        imgUrl: _downloadUrl!,
        successTxt: 'Image deleted successfully!',
      );
      setState(() => _downloadUrl = null);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: _uploadFile,
              child: const Text('Upload Local File'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteFile,
              child: const Text('Delete Image'),
            ),
          ],
        ),
      ),
    );
  }
}
