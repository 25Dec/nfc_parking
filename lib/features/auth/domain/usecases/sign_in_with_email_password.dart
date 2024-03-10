import 'package:nfc_parking/core/common/entities/user_entity.dart';

import '../../../../core/utils/typedefs.dart';
import '../repositories/auth_repo.dart';

class SignInWithEmailPassword {
  final AuthRepo _repo;

  SignInWithEmailPassword(this._repo);

  ResultFuture<UserEntity?> execute({
    required String email,
    required String password,
  }) async {
    return await _repo.signInWithEmailPassword(
      email: email,
      password: password,
    );
  }
}
