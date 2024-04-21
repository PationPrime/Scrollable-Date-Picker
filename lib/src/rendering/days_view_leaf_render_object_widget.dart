library month_leaf_render_object_widget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollable_date_picker/src/constants/constants.dart';
import 'package:scrollable_date_picker/src/models/models.dart';

import '../enums/enums.dart';

part 'days_view_render_box.dart';
part 'month_title.dart';

class DaysViewLeafRenderObjectWidget extends LeafRenderObjectWidget {
  final int daysCount;
  final int startWeekday;
  final DateTime viewDate;
  final bool betweenDates;
  final bool showWeekdays;
  final TextStyle? weekdaysNameTextStyle;
  final TextStyle? dayNumberTextStyle;
  final TextStyle? weekendDaysTextStyle;
  final TextStyle? weekendDaysNameTextStyle;
  final TextStyle? currentDateTextStyle;
  final Color? selectionColor;
  final Color? startDateColor;
  final Color? endDateColor;
  final Function(DateTime?)? onDateSelect;
  final String? localeName;
  final DateSelectionType dateSelectionType;
  final DateTime? selectedSingleDate;
  final List<DateTime>? selectedDates;
  final DateRangeModel? dateRange;

  const DaysViewLeafRenderObjectWidget({
    super.key,
    required this.viewDate,
    required this.daysCount,
    required this.startWeekday,
    this.betweenDates = false,
    this.showWeekdays = true,
    this.dayNumberTextStyle,
    this.weekdaysNameTextStyle,
    this.weekendDaysTextStyle,
    this.weekendDaysNameTextStyle,
    this.currentDateTextStyle,
    this.selectionColor,
    this.startDateColor,
    this.endDateColor,
    this.onDateSelect,
    this.localeName,
    required this.dateSelectionType,
    this.selectedSingleDate,
    this.selectedDates,
    this.dateRange,
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
        weekdayTextStyle: weekdaysNameTextStyle,
        dayNumberTextStyle: dayNumberTextStyle,
        selectionColor: selectionColor,
        startDateColor: startDateColor,
        endDateColor: endDateColor,
        currentDateColor: currentDateTextStyle,
        weekendDaysTextStyle: weekendDaysTextStyle,
        weekendDaysNameTextStyle: weekendDaysNameTextStyle,
        onDateSelect: onDateSelect,
        localeName: localeName,
        dateSelectionType: dateSelectionType,
        selectedSingleDate: selectedSingleDate,
        selectedDates: selectedDates,
        dateRange: dateRange,
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
        ..selectionColor = selectionColor
        ..startDateColor = startDateColor
        ..endDateColor = endDateColor
        ..dayNumberTextStyle = dayNumberTextStyle
        ..weekendDaysTextStyle = weekendDaysTextStyle
        ..weekendDaysNameTextStyle = weekendDaysNameTextStyle
        ..currentDateTextStyle = currentDateTextStyle
        ..onDateSelect = onDateSelect
        ..localeName = localeName
        ..dateSelectionType = dateSelectionType
        ..selectedSingleDate = selectedSingleDate
        ..selectedDates = selectedDates
        ..dateRange = dateRange;
}
