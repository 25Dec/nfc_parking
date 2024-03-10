// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_parking/core/common/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/enum/enum.dart';
import '../../../../core/errors/exception.dart';
import '../models/nfc_card_model.dart';

abstract class NfcCardsRemoteDataSource {
  Future<bool> addNewNfcCard({
    required NfcTag tag,
    required List<Map<String, dynamic>> data,
  });
  Future<bool> checkIfNfcAvailable();
  Future<void> changeCurrentNfcCardStatus({
    required NfcCardStatus status,
  });
  Future<NfcCardModel?> getCardInformation({required NfcTag tag});
  Future<List<NfcCardModel>> getAllNfcCards();
  Future<List<NfcCardModel>> getAvailableNfcCards();
  Future<List<NfcCardModel>> getInUseNfcCards();
  Future<List<NfcCardModel>> getLostNfcCards();
}

const USER_ID = "USER_ID";

class NfcCardsRemoteDataSourceImpl implements NfcCardsRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final NfcManager _nfcManager;
  final SharedPreferences _sharedPreferences;
  String userID = "";
  String ownerID = "";

  NfcCardsRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._nfcManager,
    this._sharedPreferences,
  );

  @override
  Future<bool> addNewNfcCard({
    required NfcTag tag,
    required List<Map<String, dynamic>> data,
  }) async {
    try {
      List<NfcCardModel> nfcCardsFromFirebase = await _transferQuerySnapshotToList();

      nfcCardsFromFirebase.add(NfcCardModel(
        cardID: data[0]["cardID"],
        createdAt: data[2]["createdAt"],
        ownerID: ownerID,
      ));

      List<Map<String, dynamic>> result =
          nfcCardsFromFirebase.map((nfcCard) => nfcCard.toJson()).toList();

      await _firebaseFirestore
          .collection("users")
          .doc(ownerID)
          .set({"nfcCards": result}, SetOptions(merge: true));

      return true;
    } on HardwareException catch (e) {
      throw HardwareException(message: e.message);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> changeCurrentNfcCardStatus({
    required NfcCardStatus status,
  }) async {
    try {} on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<bool> checkIfNfcAvailable() async {
    try {
      return await _nfcManager.isAvailable();
    } on HardwareException catch (e) {
      throw HardwareException(message: e.message);
    }
  }

  @override
  Future<NfcCardModel?> getCardInformation({required NfcTag tag}) async {
    try {
      NfcCardModel? nfcCardModel;
      List<Map<String, dynamic>> result = [];

      if (tag.data["ndef"]["cachedMessage"] != null) {
        final recordsFromNfcTag = tag.data["ndef"]["cachedMessage"]["records"];

        for (var record in recordsFromNfcTag) {
          if (record["payload"].isNotEmpty) {
            final payload = jsonDecode(
              String.fromCharCodes(record["payload"]).substring(3),
            );
            result.add(payload);
          }
        }
      } else {
        return null;
      }

      if (result.isNotEmpty) {
        Map<String, dynamic> json = {};

        for (Map<String, dynamic> obj in result) {
          json.addAll(obj);
        }

        nfcCardModel = NfcCardModel.fromJson(json);
      }

      return nfcCardModel;
    } on HardwareException catch (e) {
      throw HardwareException(message: e.message);
    }
  }

  @override
  Future<List<NfcCardModel>> getAllNfcCards() async {
    try {
      List<NfcCardModel> nfcCards = await _transferQuerySnapshotToList();
      return nfcCards;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<List<NfcCardModel>> getAvailableNfcCards() async {
    try {
      List<NfcCardModel> nfcCards = await _transferQuerySnapshotToList();
      nfcCards = nfcCards
          .where((card) => card.cardStatus.name == NfcCardStatus.available.name)
          .toList();

      return nfcCards;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<List<NfcCardModel>> getInUseNfcCards() async {
    try {
      List<NfcCardModel> nfcCards = await _transferQuerySnapshotToList();
      nfcCards = nfcCards
          .where((card) => card.cardStatus.name == NfcCardStatus.inUse.name)
          .toList();
      return nfcCards;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<List<NfcCardModel>> getLostNfcCards() async {
    try {
      List<NfcCardModel> nfcCards = await _transferQuerySnapshotToList();
      nfcCards = nfcCards
          .where((card) => card.cardStatus.name == NfcCardStatus.lost.name)
          .toList();
      return nfcCards;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  Future<List<NfcCardModel>> _transferQuerySnapshotToList() async {
    List<NfcCardModel> cards = [];
    userID = _sharedPreferences.getString(USER_ID)!;

    final currentUserFirebase =
        await _firebaseFirestore.collection("users").doc(userID).get();
    final currentUser = UserModel.fromJson(currentUserFirebase.data()!);

    if (currentUser.role.name == UserRole.admin.name) {
      ownerID = currentUser.userID;
      cards =
          currentUser.nfcCards.map((nfcCard) => NfcCardModel.fromJson(nfcCard)).toList();
    } else {
      final ownerUserFirebase = await _firebaseFirestore
          .collection("users")
          .doc(StaffUserModel.fromJson(currentUserFirebase.data()!).ownerID)
          .get();
      final ownerUser = AdminUserModel.fromJson(ownerUserFirebase.data()!);

      cards =
          ownerUser.nfcCards.map((nfcCard) => NfcCardModel.fromJson(nfcCard)).toList();
    }

    return cards;
  }
}
