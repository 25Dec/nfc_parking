import '../../enum/enum.dart';
import '../entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userID,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    super.nfcCards,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserRole role = UserRole.staff;

    if (json["role"] == UserRole.admin.name) {
      role = UserRole.admin;
    }

    return UserModel(
      userID: json["userID"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      role: role,
      nfcCards: List.from(json["nfcCards"]),
    );
  }

  UserModel copyWith({
    String? userID,
    String? fullName,
    String? email,
    String? phoneNumber,
    UserRole? role,
    List<Map<String, dynamic>>? nfcCards,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      nfcCards: nfcCards ?? this.nfcCards,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "role": role.toString(),
      "nfcCards": nfcCards,
    };
  }
}

class AdminUserModel extends AdminUserEntity {
  const AdminUserModel({
    required super.userID,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    super.staff,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) {
    return AdminUserModel(
      userID: json["userID"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      role: UserRole.admin,
      staff: List.from(json["staff"]),
    );
  }

  AdminUserModel copyWith({
    String? userID,
    String? fullName,
    String? email,
    String? phoneNumber,
    UserRole? role,
    List<Map<String, dynamic>>? staff,
  }) {
    return AdminUserModel(
      userID: userID ?? this.userID,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      staff: staff ?? this.staff,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "role": role.toString(),
      "staff": staff
    };
  }
}

class StaffUserModel extends StaffUserEntity {
  const StaffUserModel({
    required super.userID,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    required super.ownerID,
  });

  factory StaffUserModel.fromJson(Map<String, dynamic> json) {
    return StaffUserModel(
      userID: json["userID"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      role: UserRole.staff,
      ownerID: json["ownerID"],
    );
  }

  StaffUserModel copyWith({
    String? userID,
    String? fullName,
    String? email,
    String? phoneNumber,
    UserRole? role,
    String? ownerID,
  }) {
    return StaffUserModel(
      userID: userID ?? this.userID,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      ownerID: ownerID ?? this.ownerID,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "role": role.toString(),
      "ownerID": ownerID,
    };
  }
}
