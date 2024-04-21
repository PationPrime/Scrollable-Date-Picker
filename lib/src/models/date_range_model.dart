library src.models.date_range;

import 'package:flutter/material.dart';

@immutable
class DateRangeModel {
  final DateTime? startDate;
  final DateTime? endDate;

  const DateRangeModel({
    this.startDate,
    this.endDate,
  });

  DateRangeModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      DateRangeModel(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  @override
  bool operator ==(Object other) =>
      other is DateRangeModel &&
      other.runtimeType == runtimeType &&
      other.startDate == startDate &&
      other.endDate == endDate;

  @override
  int get hashCode => Object.hash(
        startDate,
        endDate,
      );
}
