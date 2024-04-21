library src.models.day_view;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
class DayViewModel {
  final int number;
  final Offset? center;
  final Rect? rect;
  final DateTime? date;

  const DayViewModel({
    required this.number,
    this.center,
    this.rect,
    this.date,
  });

  DayViewModel copyWith({
    int? number,
    Offset? center,
    Rect? rect,
    DateTime? date,
  }) =>
      DayViewModel(
        number: number ?? this.number,
        center: center ?? this.center,
        rect: rect ?? this.rect,
        date: date ?? this.date,
      );

  @override
  bool operator ==(Object other) =>
      other is DayViewModel &&
      other.runtimeType == runtimeType &&
      other.number == number &&
      other.center == center &&
      other.rect == rect &&
      other.date == date;

  @override
  int get hashCode => Object.hash(
        number,
        center,
        rect,
        date,
      );

  @override
  String toString() =>
      "hashCode: $hashCode, number: $number, ceneter: $center, rect: $rect, date: $date";
}
