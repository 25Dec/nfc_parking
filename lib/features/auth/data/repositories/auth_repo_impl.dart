import 'package:fpdart/fpdart.dart';

import '../../../../core/common/models/user_model.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  ResultFuture<UserModel?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      if (result != null) {
        _localDataSource.cacheUserData(user: result);
      }
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<UserModel?> getUserData() async {
    try {
      final localUserID = await _localDataSource.getCacheUserData();
      UserModel? remoteUser;

      if (localUserID != null) {
        remoteUser = await _remoteDataSource.getUserData(uid: localUserID);
      } else {
        return const Right(null);
      }

      if (remoteUser != null) {
        return Right(remoteUser);
      }
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      await _localDataSource.deleteCacheUserData();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
