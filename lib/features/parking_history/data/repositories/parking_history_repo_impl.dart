import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/parking_ticket_entity.dart';
import '../../domain/repositories/parking_history_repo.dart';

class ParkingHistoryRepoImpl implements ParkingHistoryRepo {
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
}
