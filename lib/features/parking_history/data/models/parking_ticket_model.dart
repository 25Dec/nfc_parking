import '../../domain/entities/parking_ticket_entity.dart';

class ParkingTicketModel extends ParkingTicketEntity {
  const ParkingTicketModel({
    required super.parkingTicketID,
    required super.licensePlate,
    required super.nfcCardID,
    required super.timeIn,
    super.timeOut,
    super.isLostCard,
    super.reportLostTime,
    required super.ownerID,
  });

  factory ParkingTicketModel.fromJson(Map<String, dynamic> json) {
    return ParkingTicketModel(
      parkingTicketID: json["parkingTicketID"],
      licensePlate: json["licensePlate"],
      nfcCardID: json["nfcCardID"],
      timeIn: DateTime.tryParse(json["timeIn"]),
      timeOut: DateTime.tryParse(json["timeOut"]),
      isLostCard: json["isLostCard"],
      reportLostTime: DateTime.tryParse(json["reportLostTime"]),
      ownerID: json["ownerID"],
    );
  }

  ParkingTicketModel copyWith({
    String? parkingTicketID,
    String? licensePlate,
    String? nfcCardID,
    DateTime? timeIn,
    DateTime? timeOut,
    bool? isLostCard,
    DateTime? reportLostTime,
    String? ownerID,
  }) {
    return ParkingTicketModel(
      parkingTicketID: parkingTicketID ?? this.parkingTicketID,
      licensePlate: licensePlate ?? this.licensePlate,
      nfcCardID: nfcCardID ?? this.nfcCardID,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      isLostCard: isLostCard ?? this.isLostCard,
      reportLostTime: reportLostTime ?? this.reportLostTime,
      ownerID: ownerID ?? this.ownerID,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "parkingTicketID": parkingTicketID,
      "licensePlate": licensePlate,
      "nfcCardID": nfcCardID,
      "timeIn": timeIn.toString(),
      "timeOut": timeOut.toString(),
      "isLostCard": isLostCard,
      "reportLostTime": reportLostTime.toString(),
      "ownerID": ownerID,
    };
  }
}
