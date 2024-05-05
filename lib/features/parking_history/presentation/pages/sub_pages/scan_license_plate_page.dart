import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../../core/common/widgets/custom_top_app_bar.dart';
import '../../../../../core/routes/app_route_constants.dart';
import '../../../../../core/utils/core_utils.dart';
import '../../widgets/object_detector_painter.dart';

class ScanLicensePlatePage extends StatefulWidget {
  const ScanLicensePlatePage({super.key});

  @override
  State<ScanLicensePlatePage> createState() => _ScanLicensePlatePageState();
}

class _ScanLicensePlatePageState extends State<ScanLicensePlatePage> {
  static List<CameraDescription> cameras = [];
  CameraController? controller;
  int cameraIndex = -1;
  ObjectDetector? objectDetector;
  var script = TextRecognitionScript.latin;
  var textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  DetectionMode mode = DetectionMode.stream;
  bool canProcess = false;
  bool isBusy = false;
  CustomPaint? customPaint;
  String? text;
  var cameraLensDirection = CameraLensDirection.back;
  Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  CameraLensDirection initialCameraLensDirection = CameraLensDirection.back;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    initialize();
  }

  void initialize() async {
    if (cameras.isEmpty) {
      cameras = await availableCameras();
    }
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == initialCameraLensDirection) {
        cameraIndex = i;
        break;
      }
    }
    if (cameraIndex != -1) {
      startLiveFeed();
    }
  }

  Future startLiveFeed() async {
    final camera = cameras[cameraIndex];
    controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup:
          Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
    );
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }

      controller?.startImageStream(processCameraImage).then((value) {
        initializeDetector();
      });

      setState(() {});
    });
  }

  Future stopLiveFeed() async {
    await controller?.stopImageStream();
    await controller?.dispose();
    controller = null;
  }

  void processCameraImage(CameraImage image) {
    final inputImage = inputImageFromCameraImage(image);
    if (inputImage == null) return;
    processImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? inputImageFromCameraImage(CameraImage image) {
    if (controller == null) return null;

    final camera = cameras[cameraIndex];
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = _orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  @override
  void dispose() {
    canProcess = false;
    objectDetector?.close();
    textRecognizer.close();
    stopLiveFeed();
    super.dispose();
  }

  void initializeDetector() async {
    objectDetector?.close();
    objectDetector = null;

    final modelPath = await CoreUtils.getAssetPath('assets/models/object_labeler.tflite');
    final localObjectDetectorOptions = LocalObjectDetectorOptions(
      mode: mode,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    objectDetector = ObjectDetector(options: localObjectDetectorOptions);

    canProcess = true;
  }

  Future<void> processImage(InputImage inputImage) async {
    if (objectDetector == null) return;
    if (!canProcess) return;
    if (isBusy) return;
    isBusy = true;
    setState(() => text = '');

    final objects = await objectDetector!.processImage(inputImage);
    final recognizedText = await textRecognizer.processImage(inputImage);

    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = ObjectDetectorPainter(
        objects,
        recognizedText,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        cameraLensDirection,
      );

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomTopAppBar(
        routeName: AppPage.scanLicensePlate.toName,
        cameraController: controller,
      ),
      extendBodyBehindAppBar: true,
      body: (cameras.isEmpty ||
              controller == null ||
              controller?.value.isInitialized == false)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: deviceWidth,
              height: deviceHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CameraPreview(
                    controller!,
                    child: customPaint,
                  ),
                ],
              ),
            ),
    );
  }
}
