library month_leaf_render_object_widget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_date_picker/src/constants/constants.dart';
import 'package:scrollable_date_picker/src/extensions/extensions.dart';
import 'package:scrollable_date_picker/src/models/models.dart';

import '../enums/enums.dart';

part 'days_view_render_box.dart';
part 'month_view_header.dart';

class DaysViewLeafRenderObjectWidget extends LeafRenderObjectWidget {
  final int daysCount;
  final int startWeekday;
  final DateTime viewDate;
  final bool betweenDates;
  final bool showWeekdays;
  final TextStyle? weekdaysNameTextStyle;
  final TextStyle? weekendDaysNumberTextStyle;
  final TextStyle? weekendDaysNameTextStyle;
  final TextStyle currentDateTextStyle;
  final TextStyle? futureDatesTextStyle;
  final TextStyle? dayNumberTextStyle;
  final Function(DateTime?)? onDateSelect;
  final String? localeName;
  final DateSelectionType dateSelectionType;
  final DateTime? selectedSingleDate;
  final List<DateTime> selectedDates;
  final DateRangeModel? dateRange;
  final bool futureDatesAreAvailable;
  final SingleSelectionDecoration singleSelectionDecoration;
  final RangeSelectionDecoration rangeSelectionDecoration;
  final double daysRowHeight;

  const DaysViewLeafRenderObjectWidget({
    super.key,
    required this.viewDate,
    required this.daysCount,
    required this.startWeekday,
    this.betweenDates = false,
    this.showWeekdays = true,
    this.weekdaysNameTextStyle,
    this.weekendDaysNumberTextStyle,
    this.weekendDaysNameTextStyle,
    required this.currentDateTextStyle,
    this.futureDatesTextStyle,
    this.dayNumberTextStyle,
    this.onDateSelect,
    this.localeName,
    required this.dateSelectionType,
    this.selectedSingleDate,
    required this.selectedDates,
    this.dateRange,
    required this.futureDatesAreAvailable,
    required this.singleSelectionDecoration,
    required this.rangeSelectionDecoration,
    required this.daysRowHeight,
  })  : assert(daysCount >= 28 && daysCount <= 31),
        assert(startWeekday >= 1 && startWeekday <= 7);

  @override
  DaysViewRenderBox createRenderObject(BuildContext context) =>
      DaysViewRenderBox(
        viewDate: viewDate,
        daysCount: daysCount,
        startWeekday: startWeekday,
        betweenDates: betweenDates,
        showWeekdays: showWeekdays,
        dayNumberTextStyle: dayNumberTextStyle,
        weekdaysNameTextStyle: weekdaysNameTextStyle,
        weekendDaysNumberStyle: weekendDaysNumberTextStyle,
        weekendDaysNameTextStyle: weekendDaysNameTextStyle,
        currentDateTextStyle: currentDateTextStyle,
        futureDatesTextStyle: futureDatesTextStyle,
        onDateSelect: onDateSelect,
        localeName: localeName,
        dateSelectionType: dateSelectionType,
        selectedSingleDate: selectedSingleDate,
        selectedDates: selectedDates,
        dateRange: dateRange,
        futureDatesAreAvailable: futureDatesAreAvailable,
        singleSelectionDecoration: singleSelectionDecoration,
        rangeSelectionDecoration: rangeSelectionDecoration,
        daysRowHeight: daysRowHeight,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant DaysViewRenderBox renderObject,
  ) =>
      renderObject
        ..viewDate = viewDate
        ..daysCount = daysCount
        ..startWeekday = startWeekday
        ..betweenDates = betweenDates
        ..showWeekdays = showWeekdays
        ..weekdayTextStyle = weekdaysNameTextStyle
        ..dayNumberTextStyle = dayNumberTextStyle
        ..weekendDaysTextStyle = weekendDaysNumberTextStyle
        ..weekendDaysNameTextStyle = weekendDaysNameTextStyle
        ..currentDateTextStyle = currentDateTextStyle
        ..futureDatesTextStyle = futureDatesTextStyle
        ..onDateSelect = onDateSelect
        ..localeName = localeName
        ..dateSelectionType = dateSelectionType
        ..selectedSingleDate = selectedSingleDate
        ..selectedDates = selectedDates
        ..dateRange = dateRange
        ..futureDatesAreAvailable = futureDatesAreAvailable
        ..singleSelectionDecoration = singleSelectionDecoration
        ..rangeSelectionDecoration = rangeSelectionDecoration
        ..daysRowHeight = daysRowHeight;
}
