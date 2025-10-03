// presentation/pages/camera_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../data/repositories/camera_repository_impl.dart';
import '../../../domain/usecases/take_picture.dart';
class CameraPage extends StatefulWidget {
const CameraPage({super.key});
@override
State<CameraPage> createState() => _CameraPageState();
}
class _CameraPageState extends State<CameraPage> {
String? _imagePath;
bool _isLoading = false;
// Inyección de dependencias simple
final TakePicture _takePictureUseCase =
TakePicture(CameraRepositoryImpl());
Future<void> _captureImage() async {
setState(() {
_isLoading = true;
_imagePath = null;
});
final path = await _takePictureUseCase();
setState(() {
_imagePath = path;
_isLoading = false;
});
if (path != null) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Foto guardada en la galería')),
);
} else {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Error al capturar la foto')),
);
}
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Flutter Camera App'),
backgroundColor: Colors.blueAccent,
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
_imagePath == null
? const Text('Aún no se ha capturado una foto.')
: Expanded(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Image.file(
File(_imagePath!),
fit: BoxFit.contain,
),
),
),
const SizedBox(height: 20),
if (_isLoading)
const CircularProgressIndicator()
else
ElevatedButton.icon(
onPressed: _captureImage,
icon: const Icon(Icons.camera_alt),
label: const Text('Capturar Foto'),
style: ElevatedButton.styleFrom(
padding: const
EdgeInsets.symmetric(horizontal: 30, vertical: 15),
textStyle: const TextStyle(fontSize: 18),
),
),
],
),
),
);
}
}