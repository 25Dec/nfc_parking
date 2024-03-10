import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../../core/enum/enum.dart';
import '../../domain/entities/nfc_card_entity.dart';
import '../../domain/usecases/add_new_nfc_card.dart';
import '../../domain/usecases/change_current_nfc_card_status.dart';
import '../../domain/usecases/check_if_nfc_available.dart';
import '../../domain/usecases/get_all_nfc_cards.dart';
import '../../domain/usecases/get_available_nfc_cards.dart';
import '../../domain/usecases/get_card_information.dart';
import '../../domain/usecases/get_in_use_nfc_cards.dart';
import '../../domain/usecases/get_lost_nfc_cards.dart';

part 'nfc_cards_event.dart';
part 'nfc_cards_state.dart';

class NfcCardsBloc extends Bloc<NfcCardsEvent, NfcCardsState> {
  final AddNewNfcCard _addNewNfcCard;
  final ChangeCurrentNfcCardStatus _changeCurrentNfcCardStatus;
  final CheckIfNfcAvailable _checkIfNfcAvailable;
  final GetCardInformation _getCardInformation;
  final GetAllNfcCards _getAllNfcCards;
  final GetAvailableNfcCards _getAvailableNfcCards;
  final GetInUseNfcCards _getInUseNfcCards;
  final GetLostNfcCards _getLostNfcCards;

  NfcCardsBloc({
    required AddNewNfcCard addNewNfcCard,
    required ChangeCurrentNfcCardStatus changeCurrentNfcCardStatus,
    required CheckIfNfcAvailable checkIfNfcAvailable,
    required GetCardInformation getCardInformation,
    required GetAllNfcCards getAllNfcCards,
    required GetAvailableNfcCards getAvailableNfcCards,
    required GetInUseNfcCards getInUseNfcCards,
    required GetLostNfcCards getLostNfcCards,
  })  : _addNewNfcCard = addNewNfcCard,
        _changeCurrentNfcCardStatus = changeCurrentNfcCardStatus,
        _checkIfNfcAvailable = checkIfNfcAvailable,
        _getCardInformation = getCardInformation,
        _getAllNfcCards = getAllNfcCards,
        _getAvailableNfcCards = getAvailableNfcCards,
        _getInUseNfcCards = getInUseNfcCards,
        _getLostNfcCards = getLostNfcCards,
        super(NfcCardsInitial()) {
    on<AddNewNfcCardEvent>(_onAddNewNfcCardEvent);
    on<ChangeCurrentNfcCardStatusEvent>(_onChangeCurrentNfcCardStatusEvent);
    on<CheckIfNfcAvailableEvent>(_onCheckIfNfcAvailableEvent);
    on<GetCardInformationEvent>(_onGetCardInformationEvent);
    on<GetAllNfcCardsEvent>(_onGetAllNfcCardsEvent);
    on<GetAvailableNfcCardsEvent>(_onGetAvailableNfcCardsEvent);
    on<GetInUseNfcCardsEvent>(_onGetInUseNfcCardsEvent);
    on<GetLostNfcCardsEvent>(_onGetLostNfcCardsEvent);
  }

  void _onAddNewNfcCardEvent(
    AddNewNfcCardEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _addNewNfcCard.execute(tag: event.tag, data: event.data);

    result.fold((failure) => emit(NfcCardsErrorState(message: failure.message)),
        (isSuccess) {
      isSuccess
          ? emit(AddNewNfcCardSuccessfullyState())
          : emit(NfcCardAlreadyHasDataState());
    });
  }

  void _onChangeCurrentNfcCardStatusEvent(
    ChangeCurrentNfcCardStatusEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _changeCurrentNfcCardStatus.execute(status: event.status);

    result.fold(
      (failure) => emit(NfcCardsErrorState(message: failure.message)),
      (_) => emit(ChangeCurrentNfcCardStatusuccessfullyState()),
    );
  }

  void _onCheckIfNfcAvailableEvent(
    CheckIfNfcAvailableEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _checkIfNfcAvailable.execute();

    result.fold(
      (failure) => emit(NfcCardsErrorState(message: failure.message)),
      (isNfcAvailable) =>
          isNfcAvailable ? emit(NfcAvailableState()) : emit(NfcNotAvailableState()),
    );
  }

  void _onGetCardInformationEvent(
    GetCardInformationEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _getCardInformation.execute(tag: event.tag);
    result.fold(
      (failure) => emit(NfcCardsErrorState(message: failure.message)),
      (card) {
        card != null
            ? emit(NfcCardAlreadyHasDataState())
            : emit(NfcCardDoesNotHaveDataState());
      },
    );
  }

  void _onGetAllNfcCardsEvent(
    GetAllNfcCardsEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _getAllNfcCards.execute();

    result.fold(
      (failure) => emit(NfcCardsErrorState(message: failure.message)),
      (cards) => emit(DoneGettingAllNfcCardsState(cards: cards)),
    );
  }

  void _onGetAvailableNfcCardsEvent(
    GetAvailableNfcCardsEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _getAvailableNfcCards.execute();

    result.fold(
      (failure) => emit(NfcCardsErrorState(message: failure.message)),
      (cards) => emit(DoneGettingAvailableNfcCardsState(cards: cards)),
    );
  }

  void _onGetInUseNfcCardsEvent(
    GetInUseNfcCardsEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _getInUseNfcCards.execute();

    result.fold(
      (failure) => emit(NfcCardsErrorState(message: failure.message)),
      (cards) => emit(DoneGettingInUseNfcCardsState(cards: cards)),
    );
  }

  void _onGetLostNfcCardsEvent(
    GetLostNfcCardsEvent event,
    Emitter<NfcCardsState> emit,
  ) async {
    final result = await _getLostNfcCards.execute();

    result.fold(
      (failure) => emit(NfcCardsErrorState(message: failure.message)),
      (cards) => emit(DoneGettingLostNfcCardsState(cards: cards)),
    );
  }
}
