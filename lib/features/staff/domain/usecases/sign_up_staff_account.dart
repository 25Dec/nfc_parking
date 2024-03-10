import '../../../../core/utils/typedefs.dart';
import '../repositories/staff_repo.dart';

class SignUpStaffAccount {
  final StaffRepo _repo;

  SignUpStaffAccount(this._repo);

  ResultFuture<void> execute({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    return await _repo.signUpStaffAccount(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}
