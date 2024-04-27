library src.models.date_range;

import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';

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
      other.startDate?.dateOnly == startDate?.dateOnly &&
      other.endDate?.dateOnly == endDate?.dateOnly;

  @override
  int get hashCode => Object.hash(
        startDate,
        endDate,
      );
}
