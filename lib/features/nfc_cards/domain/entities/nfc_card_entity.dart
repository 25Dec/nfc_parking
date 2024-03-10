import 'package:equatable/equatable.dart';
import 'package:nfc_parking/core/enum/enum.dart';

class NfcCardEntity extends Equatable {
  final String cardID;
  final NfcCardStatus cardStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String ownerID;

  const NfcCardEntity({
    required this.cardID,
    this.cardStatus = NfcCardStatus.available,
    required this.createdAt,
    this.updatedAt,
    required this.ownerID,
  });

  @override
  List<Object?> get props => [cardID];
}
