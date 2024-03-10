import '../../../../core/utils/typedefs.dart';
import '../entities/nfc_card_entity.dart';
import '../repositories/nfc_cards_repo.dart';

class GetLostNfcCards {
  final NfcCardsRepo _repo;

  GetLostNfcCards(this._repo);

  ResultFuture<List<NfcCardEntity>> execute() async {
    return await _repo.getLostNfcCards();
  }
}
