// data/repositories/camera_repository_impl.dart
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../../domain/repositories/camera_repository.dart';
class CameraRepositoryImpl implements CameraRepository {
late CameraController _controller;
late List<CameraDescription> _cameras;
Future<void> _initializeController() async {
_cameras = await availableCameras();
// Usar la primera cámara disponible (generalmente la trasera)
_controller = CameraController(_cameras[0],
ResolutionPreset.high);
await _controller.initialize();
}
@override
Future<String?> takePicture() async {
try {
await _initializeController();
if (!_controller.value.isInitialized) {
return null;
}
final XFile file = await _controller.takePicture();
await GallerySaver.saveImage(file.path);
await _controller.dispose();
return file.path;
} catch (e) {
print(e);
// Asegúrate de liberar el controlador en caso de error
if (_controller.value.isInitialized) {
await _controller.dispose();
}
return null;
}
}
}