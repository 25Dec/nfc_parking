import 'package:fpdart/fpdart.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../../core/enum/enum.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/nfc_card_entity.dart';
import '../../domain/repositories/nfc_cards_repo.dart';
import '../datasources/nfc_cards_remote_data_source.dart';

class NfcCardsRepoImpl implements NfcCardsRepo {
  final NfcCardsRemoteDataSource _remoteDataSource;

  NfcCardsRepoImpl(this._remoteDataSource);

  @override
  ResultFuture<bool> addNewNfcCard({
    required NfcTag tag,
    required List<Map<String, dynamic>> data,
  }) async {
    try {
      final response = await _remoteDataSource.addNewNfcCard(tag: tag, data: data);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<void> changeCurrentNfcCardStatus({
    required NfcCardStatus status,
  }) async {
    try {
      await _remoteDataSource.changeCurrentNfcCardStatus(status: status);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<bool> checkIfNfcAvailable() async {
    try {
      final result = await _remoteDataSource.checkIfNfcAvailable();
      return Right(result);
    } on HardwareException catch (e) {
      return Left(HardwareFailure(message: e.message));
    }
  }

  @override
  ResultFuture<NfcCardEntity?> getCardInformation({required NfcTag tag}) async {
    try {
      final result = await _remoteDataSource.getCardInformation(tag: tag);
      return Right(result);
    } on HardwareException catch (e) {
      return Left(HardwareFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<NfcCardEntity>> getAllNfcCards() async {
    try {
      final result = await _remoteDataSource.getAllNfcCards();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<NfcCardEntity>> getAvailableNfcCards() async {
    try {
      final result = await _remoteDataSource.getAvailableNfcCards();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<NfcCardEntity>> getInUseNfcCards() async {
    try {
      final result = await _remoteDataSource.getInUseNfcCards();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<NfcCardEntity>> getLostNfcCards() async {
    try {
      final result = await _remoteDataSource.getLostNfcCards();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
