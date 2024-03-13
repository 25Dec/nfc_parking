import 'package:camera/camera.dart';

import '../../../../core/utils/typedefs.dart';
import '../entities/parking_ticket_entity.dart';

abstract class ParkingHistoryRepo {
  ResultFuture<bool> addNewParkingTicket({
    required ParkingTicketEntity parkingTicket,
  });
  ResultFuture<void> checkout({
    required List<Map<String, dynamic>> data,
  });
  ResultFuture<CameraController> initializeCamera();
  ResultFuture<List<ParkingTicketEntity>> getRecentlyParkingHistory();
  ResultFuture<List<ParkingTicketEntity>> getOldestParkingHistory();
}
