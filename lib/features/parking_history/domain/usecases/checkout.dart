import '../../../../core/utils/typedefs.dart';
import '../repositories/parking_history_repo.dart';

class Checkout {
  final ParkingHistoryRepo _repo;

  Checkout(this._repo);

  ResultFuture<void> execute({
    required List<Map<String, dynamic>> data,
  }) async {
    return await _repo.checkout(data: data);
  }
}
