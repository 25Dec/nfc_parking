part of 'parking_history_bloc.dart';

abstract class ParkingHistoryState {}

class ParkingHistoryInitial extends ParkingHistoryState {}

class InitializeCameraSuccessfullyState extends ParkingHistoryState {
  final CameraController cameraController;
  InitializeCameraSuccessfullyState({required this.cameraController});
}

class DoneGettingRecentlyParkingHistoryState extends ParkingHistoryState {
  final List<ParkingTicketEntity> vehicles;
  DoneGettingRecentlyParkingHistoryState({required this.vehicles});
}

class DoneGettingOldestParkingHistoryState extends ParkingHistoryState {
  final List<ParkingTicketEntity> vehicles;
  DoneGettingOldestParkingHistoryState({required this.vehicles});
}

class ParkingHistoryErrorState extends ParkingHistoryState {
  final String message;
  ParkingHistoryErrorState({required this.message});
}
