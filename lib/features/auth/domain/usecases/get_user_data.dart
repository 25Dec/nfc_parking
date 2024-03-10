import 'package:nfc_parking/core/common/entities/user_entity.dart';

import '../../../../core/utils/typedefs.dart';
import '../repositories/auth_repo.dart';

class GetUserData {
  final AuthRepo _repo;

  GetUserData(this._repo);

  ResultFuture<UserEntity?> execute() async {
    return await _repo.getUserData();
  }
}
