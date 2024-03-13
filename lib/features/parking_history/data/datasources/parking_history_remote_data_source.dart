import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nfc_parking/core/errors/exception.dart';

import '../models/parking_ticket_model.dart';

abstract class ParkingHistoryRemoteDataSource {
  Future<bool> addNewParkingTicket({
    required ParkingTicketModel parkingTicket,
  });
  Future<void> checkout({
    required List<Map<String, dynamic>> data,
  });
  Future<CameraController> initializeCamera();
  Future<List<ParkingTicketModel>> getRecentlyParkingHistory();
  Future<List<ParkingTicketModel>> getOldestParkingHistory();
}

class ParkingHistoryRemoteDataSourceImpl implements ParkingHistoryRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  ParkingHistoryRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
  );

  @override
  Future<bool> addNewParkingTicket({required ParkingTicketModel parkingTicket}) {
    // TODO: implement addNewParkingTicket
    throw UnimplementedError();
  }

  @override
  Future<void> checkout({required List<Map<String, dynamic>> data}) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<List<ParkingTicketModel>> getOldestParkingHistory() {
    // TODO: implement getOldestParkingHistory
    throw UnimplementedError();
  }

  @override
  Future<List<ParkingTicketModel>> getRecentlyParkingHistory() {
    // TODO: implement getRecentlyParkingHistory
    throw UnimplementedError();
  }

  @override
  Future<CameraController> initializeCamera() async {
    try {
      List<CameraDescription> cameras = await availableCameras();

      final CameraController cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );

      return cameraController;
    } on HardwareException catch (e) {
      throw HardwareException(message: e.message);
    }
  }
}
