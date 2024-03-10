import '../../../../core/utils/typedefs.dart';
import '../entities/nfc_card_entity.dart';
import '../repositories/nfc_cards_repo.dart';

class GetAllNfcCards {
  final NfcCardsRepo _repo;

  GetAllNfcCards(this._repo);

  ResultFuture<List<NfcCardEntity>> execute() async {
    return await _repo.getAllNfcCards();
  }
}
