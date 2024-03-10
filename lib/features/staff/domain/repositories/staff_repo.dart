import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/utils/typedefs.dart';

abstract class StaffRepo {
  ResultFuture<List<StaffUserEntity>> getAllStaff();
  ResultFuture<void> signUpStaffAccount({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  });
  ResultFuture<void> deleteStaffAccount({required String staffID});
}
