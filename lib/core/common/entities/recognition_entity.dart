import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RecognitionEntity extends Equatable {
  final int _id;
  final String _label;
  final double _score;
  final Rect _location;

  const RecognitionEntity(
    this._id,
    this._label,
    this._score,
    this._location,
  );

  @override
  List<Object?> get props => [_id, _label, _score];
}
