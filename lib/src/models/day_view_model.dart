library src.models.day_view;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
class DayViewModel {
  final int number;
  final Offset? selectionCenter;
  final Offset? dayCenter;
  final Rect? rect;
  final DateTime? date;

  const DayViewModel({
    required this.number,
    this.selectionCenter,
    this.dayCenter,
    this.rect,
    this.date,
  });

  DayViewModel copyWith({
    int? number,
    Offset? selectionCenter,
    Offset? dayCenter,
    Rect? rect,
    DateTime? date,
  }) =>
      DayViewModel(
        number: number ?? this.number,
        selectionCenter: selectionCenter ?? this.selectionCenter,
        dayCenter: dayCenter ?? this.dayCenter,
        rect: rect ?? this.rect,
        date: date ?? this.date,
      );

  @override
  bool operator ==(Object other) =>
      other is DayViewModel &&
      other.runtimeType == runtimeType &&
      other.number == number &&
      other.selectionCenter == selectionCenter &&
      other.dayCenter == dayCenter &&
      other.rect == rect &&
      other.date == date;

  @override
  int get hashCode => Object.hash(
        number,
        selectionCenter,
        dayCenter,
        rect,
        date,
      );

  @override
  String toString() =>
      "hashCode: $hashCode, number: $number, paintCenter: $selectionCenter, dayCenter: $dayCenter, rect: $rect, date: $date";
}
