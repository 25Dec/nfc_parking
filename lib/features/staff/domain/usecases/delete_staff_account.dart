import '../../../../core/utils/typedefs.dart';
import '../repositories/staff_repo.dart';

class DeleteStaffAccount {
  final StaffRepo _repo;

  DeleteStaffAccount(this._repo);

  ResultFuture<void> execute({required String staffID}) async {
    return await _repo.deleteStaffAccount(staffID: staffID);
  }
}
