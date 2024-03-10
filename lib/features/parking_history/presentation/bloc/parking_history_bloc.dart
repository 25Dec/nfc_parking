import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/parking_ticket_entity.dart';

part 'parking_history_event.dart';
part 'parking_history_state.dart';

class ParkingHistoryBloc extends Bloc<ParkingHistoryEvent, ParkingHistoryState> {
  ParkingHistoryBloc() : super(ParkingHistoryInitial()) {
    on<ParkingHistoryEvent>((event, emit) {});
  }
}
