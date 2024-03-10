import '../../../../core/utils/typedefs.dart';
import '../repositories/nfc_cards_repo.dart';

class CheckIfNfcAvailable {
  final NfcCardsRepo _repo;

  CheckIfNfcAvailable(this._repo);

  ResultFuture<bool> execute() async {
    return await _repo.checkIfNfcAvailable();
  }
}
