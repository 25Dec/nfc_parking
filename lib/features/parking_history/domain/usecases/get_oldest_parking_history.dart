import '../../../../core/utils/typedefs.dart';
import '../entities/parking_ticket_entity.dart';
import '../repositories/parking_history_repo.dart';

class GetOldestParkingHistory {
  final ParkingHistoryRepo _repo;

  GetOldestParkingHistory(this._repo);

  ResultFuture<List<ParkingTicketEntity>> execute() async {
    return await _repo.getOldestParkingHistory();
  }
}
