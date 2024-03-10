import '../../../../core/utils/typedefs.dart';
import '../entities/parking_ticket_entity.dart';
import '../repositories/parking_history_repo.dart';

class GetRecentlyParkingHistory {
  final ParkingHistoryRepo _repo;

  GetRecentlyParkingHistory(this._repo);

  ResultFuture<List<ParkingTicketEntity>> execute() async {
    return await _repo.getRecentlyParkingHistory();
  }
}
