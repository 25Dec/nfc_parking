// ignore_for_file: constant_identifier_names

import 'package:nfc_parking/core/common/models/user_model.dart';
import 'package:nfc_parking/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserData({required UserModel user});
  Future<String?> getCacheUserData();
  Future<void> deleteCacheUserData();
}

const USER_ID = "USER_ID";

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<void> cacheUserData({required UserModel user}) async {
    try {
      _sharedPreferences.setString(USER_ID, user.userID);
    } on CacheException catch (e) {
      throw CacheException(message: e.message);
    }
  }

  @override
  Future<String?> getCacheUserData() async {
    try {
      final result = _sharedPreferences.getString(USER_ID);
      return result != null ? Future.value(result) : Future.value(null);
    } on CacheException catch (e) {
      throw CacheException(message: e.message);
    }
  }

  @override
  Future<void> deleteCacheUserData() async {
    try {
      await _sharedPreferences.remove(USER_ID);
    } on CacheException catch (e) {
      throw CacheException(message: e.message);
    }
  }
}
