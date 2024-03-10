import '../../../../core/utils/typedefs.dart';
import '../entities/parking_ticket_entity.dart';
import '../repositories/parking_history_repo.dart';

class AddNewParkingTicket {
  final ParkingHistoryRepo _repo;

  AddNewParkingTicket(this._repo);

  ResultFuture<bool> execute({
    required ParkingTicketEntity parkingTicket,
  }) async {
    return await _repo.addNewParkingTicket(
      parkingTicket: parkingTicket,
    );
  }
}
