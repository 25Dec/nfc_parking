import 'package:equatable/equatable.dart';

class ParkingTicketEntity extends Equatable {
  final String parkingTicketID;
  final String licensePlate;
  final String nfcCardID;
  final DateTime? timeIn;
  final DateTime? timeOut;
  final bool isLostCard;
  final DateTime? reportLostTime;
  final String ownerID;

  const ParkingTicketEntity({
    required this.parkingTicketID,
    required this.licensePlate,
    required this.nfcCardID,
    required this.timeIn,
    this.timeOut,
    this.isLostCard = false,
    this.reportLostTime,
    required this.ownerID,
  });

  @override
  List<Object?> get props => [parkingTicketID];
}
