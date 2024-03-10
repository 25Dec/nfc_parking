import '../../../../core/enum/enum.dart';
import '../../../../core/utils/typedefs.dart';
import '../repositories/nfc_cards_repo.dart';

class ChangeCurrentNfcCardStatus {
  final NfcCardsRepo _repo;

  ChangeCurrentNfcCardStatus(this._repo);

  ResultFuture<void> execute({required NfcCardStatus status}) async {
    return await _repo.changeCurrentNfcCardStatus(status: status);
  }
}
