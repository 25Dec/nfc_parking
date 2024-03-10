import 'package:equatable/equatable.dart';

import '../../enum/enum.dart';

class UserEntity extends Equatable {
  final String userID;
  final String fullName;
  final String email;
  final String phoneNumber;
  final UserRole role;
  final List<Map<String, dynamic>> nfcCards;
  final List<Map<String, dynamic>> parkingHistory;

  const UserEntity({
    required this.userID,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.nfcCards = const [],
    this.parkingHistory = const [],
  });

  @override
  List<Object?> get props => [userID];
}

class AdminUserEntity extends UserEntity {
  final List<Map<String, dynamic>> staff;

  const AdminUserEntity({
    required super.userID,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    this.staff = const [],
  });
}

class StaffUserEntity extends UserEntity {
  final String ownerID;

  const StaffUserEntity({
    required super.userID,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    required this.ownerID,
  });
}
