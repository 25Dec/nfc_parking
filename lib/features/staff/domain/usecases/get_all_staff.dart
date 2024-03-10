import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/utils/typedefs.dart';
import '../repositories/staff_repo.dart';

class GetAllStaff {
  final StaffRepo _repo;

  GetAllStaff(this._repo);

  ResultFuture<List<StaffUserEntity>> execute() async {
    return await _repo.getAllStaff();
  }
}
