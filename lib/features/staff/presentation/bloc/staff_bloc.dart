import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../../domain/usecases/delete_staff_account.dart';
import '../../domain/usecases/get_all_staff.dart';
import '../../domain/usecases/sign_up_staff_account.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final GetAllStaff _getAllStaff;
  final SignUpStaffAccount _signUpStaffAccount;
  final DeleteStaffAccount _deleteStaffAccount;

  StaffBloc({
    required GetAllStaff getAllStaff,
    required SignUpStaffAccount signUpStaffAccount,
    required DeleteStaffAccount deleteStaffAccount,
  })  : _getAllStaff = getAllStaff,
        _signUpStaffAccount = signUpStaffAccount,
        _deleteStaffAccount = deleteStaffAccount,
        super(StaffInitial()) {
    on<GetAllStaffEvent>(_onGetAllStaffEvent);
    on<SignUpStaffAccountEvent>(_onSignUpStaffAccountEvent);
    on<DeleteStaffAccountEvent>(_onDeleteStaffAccountEvent);
  }

  void _onGetAllStaffEvent(
    GetAllStaffEvent event,
    Emitter<StaffState> emit,
  ) async {
    final result = await _getAllStaff.execute();

    result.fold(
      (failure) => emit(StaffErrorState(message: failure.message)),
      (staff) => emit(DoneGettingAllStaffState(staff: staff)),
    );
  }

  void _onSignUpStaffAccountEvent(
    SignUpStaffAccountEvent event,
    Emitter<StaffState> emit,
  ) async {
    final result = await _signUpStaffAccount.execute(
      fullName: event.fullName,
      email: event.email,
      phoneNumber: event.phoneNumber,
      password: event.password,
    );

    result.fold(
      (failure) => emit(StaffErrorState(message: failure.message)),
      (_) => emit(SignUpStaffAccountSuccessfully()),
    );
  }

  void _onDeleteStaffAccountEvent(
    DeleteStaffAccountEvent event,
    Emitter<StaffState> emit,
  ) async {
    final result = await _deleteStaffAccount.execute(staffID: event.staffID);

    result.fold(
      (failure) => emit(StaffErrorState(message: failure.message)),
      (_) => emit(DeleteStaffAccountSuccessfully()),
    );
  }
}
