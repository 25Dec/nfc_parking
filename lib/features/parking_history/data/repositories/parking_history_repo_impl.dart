import 'package:camera/camera.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/parking_ticket_entity.dart';
import '../../domain/repositories/parking_history_repo.dart';
import '../datasources/parking_history_remote_data_source.dart';

class ParkingHistoryRepoImpl implements ParkingHistoryRepo {
  final ParkingHistoryRemoteDataSource _remoteDataSource;

  ParkingHistoryRepoImpl(this._remoteDataSource);

  @override
  ResultFuture<bool> addNewParkingTicket({
    required ParkingTicketEntity parkingTicket,
  }) {
    // TODO: implement addNewParkingTicket
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> checkout({
    required List<Map<String, dynamic>> data,
  }) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<ParkingTicketEntity>> getAllParkingHistory() {
    // TODO: implement getAllParkingHistory
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<ParkingTicketEntity>> getOldestParkingHistory() {
    // TODO: implement getOldestParkingHistory
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<ParkingTicketEntity>> getRecentlyParkingHistory() {
    // TODO: implement getRecentlyParkingHistory
    throw UnimplementedError();
  }

  @override
  ResultFuture<CameraController> initializeCamera() async {
    try {
      final response = await _remoteDataSource.initializeCamera();
      return Right(response);
    } on HardwareException catch (e) {
      return Left(HardwareFailure(message: e.message));
    }
  }
}
