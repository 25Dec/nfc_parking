import 'package:nfc_manager/nfc_manager.dart';

import '../../../../core/utils/typedefs.dart';
import '../entities/nfc_card_entity.dart';
import '../repositories/nfc_cards_repo.dart';

class GetCardInformation {
  final NfcCardsRepo _repo;

  GetCardInformation(this._repo);

  ResultFuture<NfcCardEntity?> execute({required NfcTag tag}) async {
    return await _repo.getCardInformation(tag: tag);
  }
}
