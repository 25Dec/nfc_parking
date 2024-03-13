import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/common/models/recognition_model.dart';
import '../../../../../core/common/widgets/bounding_box.dart';
import '../../../../../core/common/widgets/custom_top_app_bar.dart';
import '../../../../../core/routes/app_route_constants.dart';
import '../../../../../core/services/detector_service.dart';
import '../../../../../core/utils/screen_params.dart';

class ScanLicensePlatePage extends StatefulWidget {
  const ScanLicensePlatePage({super.key});

  @override
  State<ScanLicensePlatePage> createState() => _ScanLicensePlatePageState();
}

class _ScanLicensePlatePageState extends State<ScanLicensePlatePage>
    with WidgetsBindingObserver {
  late List<CameraDescription> cameras;
  CameraController? cameraController;
  get _controller => cameraController;
  Detector? detector;
  StreamSubscription? subscription;
  List<RecognitionModel>? results;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
    initStateAsync();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        cameraController?.stopImageStream();
        detector?.stop();
        subscription?.cancel();
        break;
      case AppLifecycleState.resumed:
        initStateAsync();
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    detector?.stop();
    subscription?.cancel();
    super.dispose();
  }

  void initStateAsync() async {
    Detector.start().then((instance) {
      setState(() {
        detector = instance;
        subscription = instance.resultsStream.stream.listen((values) {
          setState(() {
            results = values['recognitions'];
          });
        });
      });
    });
  }

  void initializeCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    )..initialize().then((_) async {
        await _controller.startImageStream(onLatestImageAvailable);
        setState(() {});
        ScreenParams.previewSize = _controller.value.previewSize!;
      });
  }

  void onLatestImageAvailable(CameraImage cameraImage) async {
    detector?.processFrame(cameraImage);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomTopAppBar(
        routeName: AppPage.scanLicensePlate.toName,
        cameraController: _controller,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: CameraPreview(_controller),
          ),
          results != null
              ? Stack(children: results!.map((box) => BoudingBox(result: box)).toList())
              : Container(),
        ],
      ),
    );
  }
}
