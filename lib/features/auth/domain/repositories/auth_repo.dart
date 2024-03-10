import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/utils/typedefs.dart';

abstract class AuthRepo {
  ResultFuture<UserEntity?> signInWithEmailPassword({
    required String email,
    required String password,
  });
  ResultFuture<UserEntity?> getUserData();
  ResultFuture<void> signOut();
}
