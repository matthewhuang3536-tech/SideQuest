import 'package:camera/camera.dart';

class UseCamera {


  CameraController? controller;
  List<CameraDescription> cameras = [];

  Future<void> initialize() async {
    cameras = await availableCameras();
  print("Number of cameras: ${cameras.length}");

  if(cameras.isEmpty) {
  print("no cameras");
  return;
}

  print("Camera found: ${cameras[0].name}");


  controller = CameraController(
    cameras[1], 
    ResolutionPreset.medium
    );

    await controller!.initialize();


  print("Initialized: ${controller!.value.isInitialized}");
  print("Preview size: ${controller!.value.previewSize}");
  }

  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return null;
}
  return await controller!.takePicture();
  }

  
  Future<void> switchCamera() async {
    if (cameras.length < 2) return;

    final currentCamera = controller!.description;

    final newCamera = cameras.firstWhere(
      (camera) => camera.lensDirection != currentCamera.lensDirection,
    );
    await controller!.dispose();

    controller = CameraController(
      newCamera,
      ResolutionPreset.medium,
    );
    print("Camera found: ${newCamera.name}");

    await controller!.initialize();
  }

  void dispose() {
    controller?.dispose();

  }
  
  }
