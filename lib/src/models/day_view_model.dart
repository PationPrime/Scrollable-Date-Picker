library src.models.day_view;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
class DayViewModel {
  final int number;
  final Offset? selectionCenter;
  final Offset? dayNumberCenter;
  final Rect? rect;
  final DateTime? date;
  final DateTime? monthViewOwnerDate;

  const DayViewModel({
    required this.number,
    this.selectionCenter,
    this.dayNumberCenter,
    this.rect,
    this.date,
    this.monthViewOwnerDate,
  });

  DayViewModel copyWith({
    int? number,
    Offset? selectionCenter,
    Offset? dayNumberCenter,
    Rect? rect,
    DateTime? date,
    DateTime? monthViewOwnerDate,
  }) =>
      DayViewModel(
        number: number ?? this.number,
        selectionCenter: selectionCenter ?? this.selectionCenter,
        dayNumberCenter: dayNumberCenter ?? this.dayNumberCenter,
        rect: rect ?? this.rect,
        date: date ?? this.date,
        monthViewOwnerDate: monthViewOwnerDate ?? this.monthViewOwnerDate,
      );

  @override
  bool operator ==(Object other) =>
      other is DayViewModel &&
      other.runtimeType == runtimeType &&
      other.number == number &&
      other.selectionCenter == selectionCenter &&
      other.dayNumberCenter == dayNumberCenter &&
      other.rect == rect &&
      other.date == date &&
      other.monthViewOwnerDate == monthViewOwnerDate;

  @override
  int get hashCode => Object.hash(
        number,
        selectionCenter,
        dayNumberCenter,
        rect,
        date,
        monthViewOwnerDate,
      );

  @override
  String toString() =>
      "hashCode: $hashCode, number: $number, paintCenter: $selectionCenter, dayCenter: $dayNumberCenter, rect: $rect, date: $date";
}
