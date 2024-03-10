part of 'nfc_cards_bloc.dart';

abstract class NfcCardsState {}

class NfcCardsInitial extends NfcCardsState {}

class NfcAvailableState extends NfcCardsState {}

class NfcNotAvailableState extends NfcCardsState {}

class AddNewNfcCardSuccessfullyState extends NfcCardsState {}

class ChangeCurrentNfcCardStatusuccessfullyState extends NfcCardsState {}

class NfcCardAlreadyHasDataState extends NfcCardsState {}

class NfcCardDoesNotHaveDataState extends NfcCardsState {}

class DoneGettingAllNfcCardsState extends NfcCardsState {
  final List<NfcCardEntity> cards;
  DoneGettingAllNfcCardsState({required this.cards});
}

class DoneGettingAvailableNfcCardsState extends NfcCardsState {
  final List<NfcCardEntity> cards;
  DoneGettingAvailableNfcCardsState({required this.cards});
}

class DoneGettingInUseNfcCardsState extends NfcCardsState {
  final List<NfcCardEntity> cards;
  DoneGettingInUseNfcCardsState({required this.cards});
}

class DoneGettingLostNfcCardsState extends NfcCardsState {
  final List<NfcCardEntity> cards;
  DoneGettingLostNfcCardsState({required this.cards});
}

class NfcCardsErrorState extends NfcCardsState {
  final String message;
  NfcCardsErrorState({required this.message});
}
