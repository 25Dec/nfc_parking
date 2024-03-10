part of 'staff_bloc.dart';

abstract class StaffState {}

class StaffInitial extends StaffState {}

class DoneGettingAllStaffState extends StaffState {
  final List<StaffUserEntity> staff;
  DoneGettingAllStaffState({required this.staff});
}

class SignUpStaffAccountSuccessfully extends StaffState {}

class DeleteStaffAccountSuccessfully extends StaffState {}

class StaffErrorState extends StaffState {
  final String message;
  StaffErrorState({required this.message});
}
