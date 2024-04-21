import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_date_picker/src/enums/enums.dart';
import 'package:scrollable_date_picker/src/rendering/rendering.dart';

import 'models/models.dart';

/// Widget which displays list of dates between [minDate] and [maxDate]
class ScrollableDatePicker extends StatefulWidget {
  /// The date that is displayed first on the screen
  final DateTime? initialDate;

  /// Minimum available date
  final DateTime minDate;

  /// Maximum available date
  final DateTime maxDate;

  /// Flag to controll weekday names dislpay
  final bool showWeekdays;

  /// Flag to controll weekday names repeat
  final bool repeatWeekdayNames;

  /// Flag to controll month title display
  final bool showMonthTitle;

  /// Weekday name text style
  final TextStyle? weekdaysNameTextStyle;

  /// Weekend day name text style
  final TextStyle weekendDaysNameTextStyle;

  /// Weekend day numbers text style
  final TextStyle weekendDaysTextStyle;

  /// Current day [DateTime.now().day] text style
  final TextStyle currentDateTextStyle;

  /// Month day text style
  final TextStyle? dayNumberTextStyle;

  /// Previous month days text style
  final TextStyle? previousMonthDayNumberTextStyle;

  /// Next month days text style
  final TextStyle? nextMonthDayNumberTextStyle;

  /// Month name text style
  final TextStyle? monthNameTextStyle;

  /// Future days (days after [DateTime.now()]) text style
  final TextStyle futureDatesTextStyle;

  /// Range selection color
  final Color selectionColor;

  /// Start date selection decoration
  final SelectionDecorationModel startDateSelectionDecoration;

  /// End date selection decoration
  final SelectionDecorationModel endDateSelectionDecoration;

  /// Flag to controll which dates should be displayed.
  /// If value is [true], displayes dates only between [minDate] and [maxDate],
  /// else displays dates starts from [DateTime(minDate.year, 1, 1)] to [DateTime(maxDate.year, 12, 1)]
  final bool showDatesOnlyBetweenMinAndMax;

  /// Month and weekday localization
  final String? localeName;

  /// Type of date selection (singleDate, multiDates, dateRange)
  final DateSelectionType dateSelectionType;

  /// Date selected with [DateSelectionType.singleDate] selection type
  final DateTime? selectedSingleDate;

  /// Dates selected with [DateSelectionType.multiDates] selection type
  final List<DateTime>? selectedDates;

  /// Date range from [startDate] to [endDate] with [DateSelectionType.dateRange] selection type
  final DateRangeModel? dateRange;

  /// Date selection callback
  final Function(
    DateTime?,
    List<DateTime>?,
    DateRangeModel?,
  )? onDateSelect;

  /// Scroll controller
  final ScrollController? scrollController;

  /// Scroll direction. Platform specific physics by default
  final ScrollPhysics? scrollPhysics;

  ///If non-null, forces the children to have the given extent in the scroll  direction.
  final double? itemExtent;

  /// Scroll direction. Set as [Axis.vertical] by default
  final Axis scrollDirection;

  /// Flag to display previous month days
  final bool showPreviousMonthDays;

  /// Flag to display next month days
  final bool showNextMonthDays;

  /// Value to format date inside month title
  final DateFormat? monthViewDateFormat;

  /// Flag to controll interaction with dates after [DateTime.now()]
  final bool futureDatesAreAvailable;

  ScrollableDatePicker({
    super.key,
    this.initialDate,
    required this.minDate,
    required this.maxDate,
    this.showWeekdays = true,
    this.repeatWeekdayNames = true,
    this.showMonthTitle = true,
    this.weekdaysNameTextStyle,
    this.weekendDaysNameTextStyle = const TextStyle(
      color: Colors.blue,
    ),
    this.weekendDaysTextStyle = const TextStyle(
      color: Colors.blue,
    ),
    this.currentDateTextStyle = const TextStyle(
      color: Colors.redAccent,
    ),
    this.dayNumberTextStyle,
    this.previousMonthDayNumberTextStyle,
    this.nextMonthDayNumberTextStyle,
    this.monthNameTextStyle,
    this.futureDatesTextStyle = const TextStyle(color: Colors.grey),
    this.selectionColor = const Color.fromRGBO(63, 184, 175, 0.7),
    this.startDateSelectionDecoration = const SelectionDecorationModel(),
    this.endDateSelectionDecoration = const SelectionDecorationModel(),
    this.showDatesOnlyBetweenMinAndMax = false,
    this.localeName,
    this.dateSelectionType = DateSelectionType.singleDate,
    this.selectedSingleDate,
    this.selectedDates,
    this.dateRange,
    this.onDateSelect,
    this.scrollController,
    this.scrollPhysics,
    this.itemExtent,
    this.scrollDirection = Axis.vertical,
    this.showPreviousMonthDays = false,
    this.showNextMonthDays = false,
    this.monthViewDateFormat,
    this.futureDatesAreAvailable = false,
  })  : assert(
          minDate.isBefore(maxDate),
          "Minimum date cannot be after maximum date",
        ),
        assert(
          (selectedSingleDate == null &&
                  selectedDates == null &&
                  dateRange == null) ||
              (selectedSingleDate != null &&
                  selectedDates == null &&
                  dateRange == null) ||
              (selectedSingleDate == null &&
                  selectedDates != null &&
                  dateRange == null) ||
              selectedSingleDate == null &&
                  selectedDates == null &&
                  dateRange != null,
        );

  @override
  State<ScrollableDatePicker> createState() => _ScrollableDatePickerState();
}

class _ScrollableDatePickerState extends State<ScrollableDatePicker> {
  late final ScrollController _scrollController;
  late List<DateTime> _dates;
  late int _monthCount;
  DateTime? _initialDate;
  DateTime? _selectedSingleDate;
  DateRangeModel? _dateRange;
  late final List<DateTime> _selectedDates;

  final _dateTimeNow = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  void _generateDates() {
    _dates = [];

    int year = widget.minDate.year;
    int currentMonth = 1;

    for (int i = currentMonth; i <= _monthCount; i++) {
      _dates.add(
        DateTime(year, currentMonth),
      );

      currentMonth++;

      if (currentMonth % 13 == 0) {
        year++;
        currentMonth = 1;
      }
    }
  }

  void _onDateSelect(DateTime? date) {
    switch (widget.dateSelectionType) {
      case DateSelectionType.singleDate:
        _singleDateSelect(date);

      case DateSelectionType.multiDates:
        if (date is! DateTime) {
          return;
        }

        _addSelectedDate(date);

      case DateSelectionType.dateRange:
        _selectDateRange(date);
    }
  }

  void _selectDateRange(
    DateTime? date, {
    bool triggerCallback = true,
  }) {
    if (_dateRange?.startDate is DateTime && _dateRange?.endDate is DateTime) {
      _dateRange = null;
    }

    if (_dateRange?.startDate is! DateTime) {
      _startDateSelect(date);
    } else if (_dateRange?.endDate is! DateTime) {
      _endDateSelect(date);
    }
    if (triggerCallback) widget.onDateSelect?.call(null, null, _dateRange);
  }

  void _singleDateSelect(DateTime? date) {
    setState(
      () => _selectedSingleDate = date,
    );

    widget.onDateSelect?.call(date, null, null);
  }

  void _startDateSelect(DateTime? date) {
    setState(
      () => _dateRange = DateRangeModel(
        startDate: date,
      ),
    );
  }

  void _endDateSelect(DateTime? date) {
    setState(
      () => _dateRange = _dateRange?.copyWith(
        endDate: date,
      ),
    );
  }

  void _addSelectedDate(
    DateTime date, {
    bool triggerCallback = true,
  }) {
    _selectedDates.contains(date)
        ? setState(() {
            _selectedDates.remove(date);
          })
        : setState(() {
            _selectedDates.add(date);
          });

    if (triggerCallback) widget.onDateSelect?.call(null, _selectedDates, null);
  }

  void _onMonthTitleTap(DateTime date) {
    switch (widget.dateSelectionType) {
      case DateSelectionType.singleDate:
        _singleDateSelect(date);
      case DateSelectionType.multiDates:
        final lastDayInMonth = date.copyWith(day: 0, month: date.month + 1).day;

        if (_selectedDates.isNotEmpty) _selectedDates.clear();

        for (int day = 1; day <= lastDayInMonth; day++) {
          _addSelectedDate(
            date.copyWith(day: day),
            triggerCallback: day == lastDayInMonth,
          );
        }

      case DateSelectionType.dateRange:
        _selectDateRange(date, triggerCallback: false);
        _selectDateRange(date.copyWith(day: 0, month: date.month + 1));
    }
  }

  Future<void> _initDateFormatting() async {
    try {
      await initializeDateFormatting();
    } catch (error, stackTrace) {
      throw Exception(
        "initializeDateFormatting() error: $error\nstackTrace:$stackTrace",
      );
    }
  }

  void _cumputeMonthsCount() {
    final yearDifference = widget.maxDate.year - widget.minDate.year + 1;
    _monthCount = yearDifference == 1 ? 12 : yearDifference * 12;
  }

  void _initDates() {
    _selectedSingleDate = widget.selectedSingleDate;
    _selectedDates = widget.selectedDates ?? [];
    _dateRange = widget.dateRange;

    _initialDate = widget.initialDate ??
        (_dates.contains(_dateTimeNow) ? _dateTimeNow : null);
  }

  void _initScrollController() {
    _scrollController = widget.scrollController ?? ScrollController();
  }

  void _init() {
    _initDateFormatting();

    setState(
      () {
        _cumputeMonthsCount();
        _generateDates();
        _initDates();
        _initScrollController();
      },
    );
  }

  void _clearDates() {
    setState(() {
      _selectedSingleDate = null;
      _dateRange = null;
      _selectedDates.clear();
      widget.onDateSelect?.call(null, null, null);
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void didUpdateWidget(covariant ScrollableDatePicker oldWidget) {
    if (oldWidget.dateSelectionType != widget.dateSelectionType) {
      _clearDates();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemExtent: widget.itemExtent,
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        physics: widget.scrollPhysics,
        itemCount: _dates.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              if (widget.showMonthTitle)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MonthTitle(
                    onTap: () => _onMonthTitleTap(
                      _dates[index],
                    ),
                    title: widget.monthViewDateFormat?.format(_dates[index]) ??
                        DateFormat(
                          "MMMM${_dates[index].year != _dateTimeNow.year ? ", ${_dates[index].year}" : ""}",
                        ).format(_dates[index]),
                    textStyle: widget.monthNameTextStyle,
                  ),
                ),
              DaysViewLeafRenderObjectWidget(
                daysCount: _dates[index]
                    .copyWith(
                      month: _dates[index].month + 1,
                      day: 0,
                    )
                    .day,
                startWeekday: _dates[index].weekday,
                viewDate: _dates[index],
                betweenDates: _dateRange?.startDate is DateTime &&
                    _dateRange!.startDate!.isBefore(_dates[index]) &&
                    _dateRange?.endDate is DateTime &&
                    _dateRange!.endDate!.isAfter(_dates[index]),
                showWeekdays: widget.showWeekdays,
                selectionColor: widget.selectionColor,
                startDateSelectionDecoration:
                    widget.startDateSelectionDecoration,
                endDateSelectionDecoration: widget.endDateSelectionDecoration,
                weekdaysNameTextStyle: widget.weekdaysNameTextStyle,
                weekendDaysTextStyle: widget.weekendDaysTextStyle,
                weekendDaysNameTextStyle: widget.weekendDaysNameTextStyle,
                currentDateTextStyle: widget.currentDateTextStyle,
                futureDatesTextStyle: widget.futureDatesTextStyle,
                dayNumberTextStyle: widget.dayNumberTextStyle,
                previousMonthDayNumberTextStyle:
                    widget.previousMonthDayNumberTextStyle,
                nextMonthDayNumberTextStyle: widget.nextMonthDayNumberTextStyle,
                onDateSelect: _onDateSelect,
                localeName: widget.localeName,
                dateSelectionType: widget.dateSelectionType,
                selectedSingleDate: _selectedSingleDate,
                selectedDates: _selectedDates,
                dateRange: _dateRange,
                showPreviousMonthDays: widget.showPreviousMonthDays,
                showNextMonthDays: widget.showNextMonthDays,
                futureDatesAreAvailable: widget.futureDatesAreAvailable,
              ),
            ],
          ),
        ),
      );
}
