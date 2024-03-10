part of 'staff_bloc.dart';

abstract class StaffEvent {}

class GetAllStaffEvent extends StaffEvent {}

class SignUpStaffAccountEvent extends StaffEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  SignUpStaffAccountEvent({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
}

class DeleteStaffAccountEvent extends StaffEvent {
  final String staffID;

  DeleteStaffAccountEvent({required this.staffID});
}
