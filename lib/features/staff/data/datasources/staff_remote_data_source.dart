// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/common/models/user_model.dart';
import '../../../../core/enum/enum.dart';
import '../../../../core/errors/exception.dart';

abstract class StaffRemoteDataSource {
  Future<List<StaffUserModel>> getAllStaff();
  Future<void> signUpStaffAccount({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  });
  Future<void> deleteStaffAccount({required String staffID});
}

const USER_ID = "USER_ID";

class StaffRemoteDataSourceImpl implements StaffRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final SharedPreferences _sharedPreferences;
  String ownerID = "";

  StaffRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
    this._sharedPreferences,
  );

  @override
  Future<List<StaffUserModel>> getAllStaff() async {
    try {
      ownerID = _sharedPreferences.getString(USER_ID)!;

      List<StaffUserModel> staff = await _transferQuerySnapshotToList();

      return staff;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> signUpStaffAccount({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      List<StaffUserModel> staffFromFirebase = await _transferQuerySnapshotToList();

      final staffUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      staffFromFirebase.add(
        StaffUserModel(
          userID: staffUser.user!.uid,
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          role: UserRole.staff,
          ownerID: ownerID,
        ),
      );

      List<Map<String, dynamic>> result =
          staffFromFirebase.map((staff) => staff.toJson()).toList();

      await _firebaseFirestore
          .collection("users")
          .doc(ownerID)
          .set({"staff": result}, SetOptions(merge: true));
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> deleteStaffAccount({required String staffID}) async {
    List<StaffUserModel> staffFromFirebase = await _transferQuerySnapshotToList();

    staffFromFirebase.removeWhere((staff) => staff.userID == staffID);

    List<Map<String, dynamic>> result =
        staffFromFirebase.map((staff) => staff.toJson()).toList();

    await _firebaseFirestore
        .collection("users")
        .doc(ownerID)
        .set({"staff": result}, SetOptions(merge: true));
  }

  Future<List<StaffUserModel>> _transferQuerySnapshotToList() async {
    final currentUserData =
        await _firebaseFirestore.collection("users").doc(ownerID).get();
    List<StaffUserModel> staff = AdminUserModel.fromJson(currentUserData.data()!)
        .staff
        .map((staff) => StaffUserModel.fromJson(staff))
        .toList();

    return staff;
  }
}
