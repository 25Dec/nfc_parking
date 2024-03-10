import '../../../../core/enum/enum.dart';
import '../../domain/entities/nfc_card_entity.dart';

class NfcCardModel extends NfcCardEntity {
  const NfcCardModel({
    required super.cardID,
    super.cardStatus,
    required super.createdAt,
    super.updatedAt,
    required super.ownerID,
  });

  factory NfcCardModel.fromJson(Map<String, dynamic> json) {
    NfcCardStatus cardStatus = NfcCardStatus.available;

    if (json["cardStatus"] == NfcCardStatus.inUse.name) {
      cardStatus = NfcCardStatus.inUse;
    } else if (json["cardStatus"] == NfcCardStatus.lost.name) {
      cardStatus = NfcCardStatus.lost;
    }

    return NfcCardModel(
      cardID: json["cardID"],
      cardStatus: cardStatus,
      createdAt: DateTime.tryParse(json["createdAt"]),
      updatedAt: DateTime.tryParse(json["updatedAt"]),
      ownerID: json["ownerID"],
    );
  }

  NfcCardModel copyWith({
    String? cardID,
    NfcCardStatus? cardStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? ownerID,
  }) {
    return NfcCardModel(
      cardID: cardID ?? this.cardID,
      cardStatus: cardStatus ?? this.cardStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ownerID: ownerID ?? this.ownerID,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cardID": cardID,
      "cardStatus": cardStatus.name,
      "createdAt": createdAt.toString(),
      "updatedAt": updatedAt.toString(),
      "ownerID": ownerID,
    };
  }
}
