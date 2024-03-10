import '../../../../core/utils/typedefs.dart';
import '../repositories/auth_repo.dart';

class SignOut {
  final AuthRepo _repo;

  SignOut(this._repo);

  ResultFuture<void> execute() async {
    return await _repo.signOut();
  }
}
