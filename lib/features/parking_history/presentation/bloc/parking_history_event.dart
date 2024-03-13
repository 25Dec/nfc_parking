part of 'parking_history_bloc.dart';

abstract class ParkingHistoryEvent {}

class InitializeCameraEvent extends ParkingHistoryEvent {}

class AddNewParkingTicketEvent extends ParkingHistoryEvent {}
