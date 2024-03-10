import 'package:nfc_manager/nfc_manager.dart';

import '../../../../core/utils/typedefs.dart';
import '../repositories/nfc_cards_repo.dart';

class AddNewNfcCard {
  final NfcCardsRepo _repo;

  AddNewNfcCard(this._repo);

  ResultFuture<bool> execute({
    required NfcTag tag,
    required List<Map<String, dynamic>> data,
  }) async {
    return await _repo.addNewNfcCard(tag: tag, data: data);
  }
}
