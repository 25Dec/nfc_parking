import 'package:nfc_manager/nfc_manager.dart';

import '../../../../core/enum/enum.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/nfc_card_entity.dart';

abstract class NfcCardsRepo {
  ResultFuture<bool> addNewNfcCard({
    required NfcTag tag,
    required List<Map<String, dynamic>> data,
  });
  ResultFuture<bool> checkIfNfcAvailable();
  ResultFuture<void> changeCurrentNfcCardStatus({
    required NfcCardStatus status,
  });
  ResultFuture<NfcCardEntity?> getCardInformation({
    required NfcTag tag,
  });
  ResultFuture<List<NfcCardEntity>> getAllNfcCards();
  ResultFuture<List<NfcCardEntity>> getAvailableNfcCards();
  ResultFuture<List<NfcCardEntity>> getInUseNfcCards();
  ResultFuture<List<NfcCardEntity>> getLostNfcCards();
}
