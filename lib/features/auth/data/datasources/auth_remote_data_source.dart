// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/common/models/user_model.dart';
import '../../../../core/errors/exception.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<UserModel?> getUserData({required String uid});
}

const USER_INFO = "USER_INFO";

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  String onwerID = "";

  AuthRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
  );

  @override
  Future<UserModel?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw ServerException(
          message: 'Please try again later',
        );
      }

      onwerID = user.uid;

      final userData = await _getUserData(onwerID);

      if (userData.exists) {
        return UserModel.fromJson(userData.data()!);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message!);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel?> getUserData({required String uid}) async {
    final result = await _getUserData(uid);
    return UserModel.fromJson(result.data()!);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData(
    String uid,
  ) async {
    return await _firebaseFirestore.collection("users").doc(uid).get();
  }
}
