part of 'nfc_cards_bloc.dart';

abstract class NfcCardsEvent {}

class AddNewNfcCardEvent extends NfcCardsEvent {
  final NfcTag tag;
  final List<Map<String, dynamic>> data;
  AddNewNfcCardEvent({required this.tag, required this.data});
}

class ChangeCurrentNfcCardStatusEvent extends NfcCardsEvent {
  final NfcCardStatus status;
  ChangeCurrentNfcCardStatusEvent({required this.status});
}

class CheckIfNfcAvailableEvent extends NfcCardsEvent {}

class GetCardInformationEvent extends NfcCardsEvent {
  final NfcTag tag;
  GetCardInformationEvent({required this.tag});
}

class GetAllNfcCardsEvent extends NfcCardsEvent {}

class GetAvailableNfcCardsEvent extends NfcCardsEvent {}

class GetInUseNfcCardsEvent extends NfcCardsEvent {}

class GetLostNfcCardsEvent extends NfcCardsEvent {}
