import '../../../../core/utils/typedefs.dart';
import '../entities/parking_ticket_entity.dart';
import '../repositories/parking_history_repo.dart';

class GetAllParkingHistory {
  final ParkingHistoryRepo _repo;

  GetAllParkingHistory(this._repo);

  ResultFuture<List<ParkingTicketEntity>> execute() async {
    return await _repo.getAllParkingHistory();
  }
}
