import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/parking_ticket_entity.dart';
import '../../domain/usecases/initialize_camera.dart';

part 'parking_history_event.dart';
part 'parking_history_state.dart';

class ParkingHistoryBloc extends Bloc<ParkingHistoryEvent, ParkingHistoryState> {
  final InitializeCamera _initializeCamera;

  ParkingHistoryBloc({
    required InitializeCamera initializeCamera,
  })  : _initializeCamera = initializeCamera,
        super(ParkingHistoryInitial()) {
    on<InitializeCameraEvent>(_onInitializeCameraEvent);
  }

  void _onInitializeCameraEvent(
    InitializeCameraEvent event,
    Emitter<ParkingHistoryState> emit,
  ) async {
    final response = await _initializeCamera.execute();

    response.fold(
      (failure) => emit(ParkingHistoryErrorState(message: failure.message)),
      (cameraController) => emit(
        InitializeCameraSuccessfullyState(cameraController: cameraController),
      ),
    );
  }
}
