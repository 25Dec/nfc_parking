import 'package:camera/camera.dart';

import '../../../../core/utils/typedefs.dart';
import '../repositories/parking_history_repo.dart';

class InitializeCamera {
  final ParkingHistoryRepo _repo;

  InitializeCamera(this._repo);

  ResultFuture<CameraController> execute() async {
    return await _repo.initializeCamera();
  }
}
