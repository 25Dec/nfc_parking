import 'package:fpdart/fpdart.dart';

import '../../../../core/common/models/user_model.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repositories/staff_repo.dart';
import '../datasources/staff_remote_data_source.dart';

class StaffRepoImpl implements StaffRepo {
  final StaffRemoteDataSource _remoteDataSource;

  StaffRepoImpl(this._remoteDataSource);

  @override
  ResultFuture<List<StaffUserModel>> getAllStaff() async {
    try {
      final result = await _remoteDataSource.getAllStaff();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<void> signUpStaffAccount({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUpStaffAccount(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  ResultFuture<void> deleteStaffAccount({required String staffID}) async {
    try {
      await _remoteDataSource.deleteStaffAccount(staffID: staffID);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
