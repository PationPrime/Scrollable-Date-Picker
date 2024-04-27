import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';
import 'package:scrollable_date_picker/src/rendering/rendering.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'typedefs/typedefs.dart';

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
  final bool showHeaderTitle;

  /// Weekday name text style
  final TextStyle? weekdaysNameTextStyle;

  /// Weekend day name text style
  final TextStyle? weekendDaysNameTextStyle;

  /// Weekend day numbers text style
  final TextStyle? weekendDaysTextStyle;

  /// Current day [DateTime.now().day] text style
  final TextStyle currentDateTextStyle;

  /// Month day text style
  final TextStyle? dayNumberTextStyle;

  /// Month name text style
  final TextStyle? headerTextStyle;

  /// Future days (days after [DateTime.now()]) text style
  final TextStyle futureDatesTextStyle;

  /// Flag to controll which dates should be displayed.
  /// If value is [true], displayes dates only between [minDate] and [maxDate],
  /// else displays dates starts from [DateTime(minDate.year, 1, 1)] to [DateTime(maxDate.year, 12, 1)]
  final bool showDatesOnlyBetweenMinAndMax;

  /// Month and weekday localization
  final String? localeName;

  /// Type of date selection [DateSelectionType.singleDate], [DateSelectionType.multipleDates], [DateSelectionType.dateRange]
  final DateSelectionType dateSelectionType;

  /// Date selected with [DateSelectionType.singleDate] selection type
  final DateTime? selectedSingleDate;

  /// Dates selected with [DateSelectionType.multipleDates] selection type
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

  /// Value to format date inside month title
  final DateFormat? headerDateFormat;

  /// Flag to controll interaction with dates after [DateTime.now()]
  final bool futureDatesAreAvailable;

  /// [DateSelectionType.singleDate] and [DateSelectionType.multipleDates]
  /// decoration configuration
  final SingleSelectionDecoration singleSelectionDecoration;

  /// [DateSelectionType.dateRange] decoration configuration
  final RangeSelectionDecoration rangeSelectionDecoration;

  /// Days row height.
  /// Used to controll height of each week row in month view
  final double daysRowHeight;

  /// Visual decoration for month title
  final BoxDecoration? headerDecoration;

  /// typedef function used for title customization
  final HeaderBuilder? headerBuilder;

  /// Title padding
  final EdgeInsets headerPadding;

  /// ListView padding
  final EdgeInsets datePickerPadding;

  /// Month view padding
  final EdgeInsets monthViewPadding;

  /// Month view height
  final double? monthViewHeight;

  /// Month view width
  final double? monthViewWidth;

  /// Header selection color
  final Color headerColor;

  /// Flag to controll scrolling to initial date time
  final bool scrollToInitialDate;

  ScrollableDatePicker({
    super.key,
    this.initialDate,
    required this.minDate,
    required this.maxDate,
    this.showWeekdays = true,
    this.repeatWeekdayNames = true,
    this.showHeaderTitle = true,
    this.weekdaysNameTextStyle,
    this.weekendDaysNameTextStyle,
    this.weekendDaysTextStyle,
    this.currentDateTextStyle = const TextStyle(
      color: Colors.redAccent,
    ),
    this.dayNumberTextStyle,
    this.headerTextStyle,
    this.futureDatesTextStyle = const TextStyle(color: Colors.grey),
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
    this.headerDateFormat,
    this.futureDatesAreAvailable = false,
    this.singleSelectionDecoration = const SingleSelectionDecoration(
      shape: BoxShape.circle,
      color: Color(0xFF3FB8AF),
      height: 20,
    ),
    this.rangeSelectionDecoration = const RangeSelectionDecoration(
      color: Color.fromARGB(200, 63, 184, 175),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      height: 30,
      startDateSelectionDecoration: SingleSelectionDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF3FB8AF),
        height: 20,
      ),
      endDateSelectionDecoration: SingleSelectionDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF3FB8AF),
        height: 20,
      ),
    ),
    this.daysRowHeight = 45.0,
    this.headerDecoration,
    this.headerBuilder,
    this.headerPadding = const EdgeInsets.symmetric(
      vertical: 20,
    ),
    this.datePickerPadding = const EdgeInsets.only(),
    this.monthViewPadding = const EdgeInsets.only(),
    this.monthViewHeight,
    this.monthViewWidth,
    this.headerColor = const Color(0xFF3FB8AF),
    this.scrollToInitialDate = true,
  })  : assert(
          minDate.isBefore(maxDate),
          "Minimum date cannot be after maximum date",
        ),
        assert(
          () {
            if (initialDate is DateTime &&
                (initialDate.isBefore(minDate) ||
                    initialDate.isAfter(maxDate))) {
              throw FlutterError(
                "Initial date error: minDate <= initialDate <= maxDate is not true",
              );
            }

            return true;
          }(),
        ),
        assert(() {
          final condition = switch (dateSelectionType) {
            DateSelectionType.singleDate =>
              selectedDates is List<DateTime> || dateRange is DateRangeModel
                  ? FlutterError(
                      "If DateSelectionType is singleDate, selectedDates and dateRange must be null.",
                    )
                  : null,
            DateSelectionType.multipleDates =>
              selectedSingleDate is DateTime || dateRange is DateRangeModel
                  ? FlutterError(
                      "If DateSelectionType is multipleDates, selectedSingleDate and dateRange must be null.",
                    )
                  : null,
            DateSelectionType.dateRange =>
              selectedDates is List<DateTime> || selectedSingleDate is DateTime
                  ? FlutterError(
                      "If DateSelectionType is dateRange, selectedDates and selectedSingleDate must be null.",
                    )
                  : null,
          };

          if (condition != null) {
            throw condition;
          }

          return true;
        }()),
        assert(
          () {
            if (dateRange is DateRangeModel &&
                (dateRange.startDate?.dateOnly is DateTime &&
                    dateRange.endDate?.dateOnly is DateTime &&
                    dateRange.endDate!.dateOnly
                        .isBefore(dateRange.startDate!.dateOnly))) {
              throw FlutterError(
                "endDate cannot be before startDate in dateRange",
              );
            }

            return true;
          }(),
        ),
        assert(
          () {
            return true;
          }(),
        ),
        assert(() {
          if (futureDatesAreAvailable) {
            return true;
          }

          if (dateSelectionType.isSingleDate &&
              selectedSingleDate is DateTime &&
              selectedSingleDate.dateOnly.isAfter(DateTime.now().dateOnly)) {
            throw FlutterError(
              "If futureDatesAreAvailable is false, selectedSingleDate cannot be after date time now",
            );
          } else if (dateSelectionType.isMultiDates &&
              selectedDates is List<DateTime> &&
              selectedDates.any(
                (date) => date.dateOnly.isAfter(DateTime.now().dateOnly),
              )) {
            throw FlutterError(
              "If futureDatesAreAvailable is false, selectedDates cannot contain dates after date time now",
            );
          } else if (dateSelectionType.isDateRange &&
              dateRange is DateRangeModel &&
              (dateRange.startDate?.dateOnly is DateTime &&
                      dateRange.startDate!.dateOnly
                          .isAfter(DateTime.now().dateOnly) ||
                  dateRange.endDate?.dateOnly is DateTime &&
                      dateRange.endDate!.dateOnly
                          .isAfter(DateTime.now().dateOnly))) {
            throw FlutterError(
              "If futureDatesAreAvailable is false, dateRange cannot contain dates after date time now",
            );
          }

          return true;
        }());

  @override
  State<ScrollableDatePicker> createState() => _ScrollableDatePickerState();
}

class _ScrollableDatePickerState extends State<ScrollableDatePicker> {
  /// [ListController] allows to control [SuperListView] scrolling.
  late final ListController _listController;

  /// [ScrollController] allows to control [SuperListView] scrolling.
  late final ScrollController _scrollController;

  /// Dislpayed dates
  late List<DateTime> _dates;

  /// Count of dislpayed months
  late int _monthCount;

  /// Initial date
  DateTime? _initialDate;

  /// Date selected in [DateSelectionType.singleDate] mode
  DateTime? _selectedSingleDate;

  /// Date selected in [DateSelectionType.dateRange] mode
  DateRangeModel? _dateRange;

  /// Date selected in [DateSelectionType.multipleDates] mode
  final List<DateTime> _selectedDates = [];

  /// Date time now, but date only
  final _dateTimeNow = DateTime.now().dateOnly;

  /// On date select method.
  /// Calls a date selection method depending on [DateSelectionType]
  void _onDateSelect(DateTime? date) {
    switch (widget.dateSelectionType) {
      case DateSelectionType.singleDate:
        _singleDateSelect(date);

      case DateSelectionType.multipleDates:
        if (date is! DateTime) {
          return;
        }

        _addSelectedDate(date);

      case DateSelectionType.dateRange:
        _onDateForDateRangeSelect(date);
    }
  }

  /// Select date range from [startDate] to [endDate] method
  void _onDateForDateRangeSelect(
    DateTime? date, {
    bool triggerCallback = true,
  }) {
    /// Check if date range has been selected.
    /// If [true], unselect date range
    if (_dateRange?.startDate is DateTime && _dateRange?.endDate is DateTime) {
      setState(
        () => _dateRange = null,
      );
    }

    /// Check if [startDate] has not been selected.
    /// If [true], select [startDate]
    if (_dateRange?.startDate is! DateTime) {
      _startDateSelect(
        date,
      );
    }

    /// Else if [startDate] has been selected,
    /// but [endDate] not, select [endDate]
    else if (_dateRange?.endDate is! DateTime) {
      _endDateSelect(
        date,
      );

      /// Check if [startDate] is after [endDate].
      /// If [true], swap dates
      if (_dateRange!.endDate!.isBefore(_dateRange!.startDate!)) {
        _swapDatesInDateRange();
      }
    }

    /// If [triggerCallback == true] callback dates
    if (triggerCallback) widget.onDateSelect?.call(null, null, _dateRange);
  }

  void _selectFullDateRange(
    DateTime? startDate,
    DateTime? endDate, {
    bool triggerCallback = true,
  }) {
    _onDateForDateRangeSelect(
      startDate,
      triggerCallback: triggerCallback,
    );

    _onDateForDateRangeSelect(
      endDate,
      triggerCallback: triggerCallback,
    );
  }

  /// Swap dates method
  void _swapDatesInDateRange() {
    final firstDate = _dateRange!.endDate;
    final lastDate = _dateRange!.startDate;

    _startDateSelect(firstDate);
    _endDateSelect(lastDate);
  }

  /// Select single date method
  void _singleDateSelect(
    DateTime? date, {
    bool triggerCallback = true,
  }) {
    setState(
      () => _selectedSingleDate = date?.dateOnly,
    );

    if (triggerCallback) {
      widget.onDateSelect?.call(date, null, null);
    }
  }

  /// Select [startDate] for [_dateRange] method
  void _startDateSelect(
    DateTime? date,
  ) =>
      setState(
        () => _dateRange = DateRangeModel(
          startDate: date,
        ),
      );

  /// Select [endDate] for [_dateRange] method
  void _endDateSelect(DateTime? date) => setState(
        () => _dateRange = _dateRange?.copyWith(
          endDate: date,
        ),
      );

  /// Add each single date to [_selectedDates] list method
  void _addSelectedDate(
    DateTime date, {
    bool triggerCallback = true,
  }) {
    /// Check if [_selectedDates] already constains date.
    /// If [true] remove date, else add it
    setState(
      () => _selectedDates.contains(date)
          ? _selectedDates.remove(date)
          : _selectedDates.add(date),
    );

    if (!triggerCallback) {
      return;
    }

    /// If [triggerCallback == true] callback dates
    widget.onDateSelect?.call(
      null,
      _selectedDates,
      null,
    );
  }

  /// Check whether any date of the month has been selected method
  bool anyDateInMonthSelected(DateTime date) =>
      widget.dateSelectionType.isDateRange &&
          _dateRange is DateRangeModel &&
          _dateRange?.startDate is DateTime &&
          _dateRange?.endDate is DateTime &&
          date.isAfter(_dateRange!.startDate!) &&
          date.isBefore(_dateRange!.endDate!) ||
      date == _dateRange?.startDate?.copyWith(day: date.day) ||
      widget.dateSelectionType.isMultiDates &&
          (date == _dateRange?.endDate ||
              _selectedDates.any((d) => d.copyWith(day: date.day) == date)) ||
      widget.dateSelectionType.isSingleDate &&
          _selectedSingleDate?.copyWith(day: date.day) == date;

  /// On header tap callback method
  void _onHeaderTap(DateTime date) {
    date = date.dateOnly;

    switch (widget.dateSelectionType) {
      case DateSelectionType.singleDate:
        if (date.isAfter(_dateTimeNow) && !widget.futureDatesAreAvailable) {
          return;
        }

        _singleDateSelect(date);

      case DateSelectionType.multipleDates:
        if (date.isAfter(_dateTimeNow) && !widget.futureDatesAreAvailable) {
          return;
        }

        final lastDayInMonth =
            date.copyWith(day: _dateTimeNow.day) == _dateTimeNow &&
                    !widget.futureDatesAreAvailable
                ? _dateTimeNow.day
                : date.copyWith(day: 0, month: date.month + 1).day;

        if (_selectedDates.isNotEmpty) _clearSelectedDates();

        for (int day = 1; day <= lastDayInMonth; day++) {
          _addSelectedDate(
            date.copyWith(day: day),
            triggerCallback: day == lastDayInMonth,
          );
        }

      case DateSelectionType.dateRange:
        final startDate = date;
        DateTime endDate = date.copyWith(
          day: 0,
          month: date.month + 1,
        );

        if (startDate.isAfter(_dateTimeNow) &&
            !widget.futureDatesAreAvailable) {
          return;
        }

        _clearDateRange();

        _onDateForDateRangeSelect(
          startDate,
          triggerCallback: false,
        );

        if (endDate.isAfter(_dateTimeNow) && !widget.futureDatesAreAvailable) {
          endDate = _dateTimeNow;
        }

        _onDateForDateRangeSelect(endDate);
    }
  }

  /// Compute months count method
  void _cumputeMonthsCount() {
    _monthCount = _getMonthDifference(widget.minDate, widget.maxDate);
  }

  /// Get difference of minDate and maxDate in months method
  int _getMonthDifference(DateTime from, DateTime to) {
    int yearDifference = to.year - from.year;
    int monthDifference = max(to.month - from.month, 0);

    int difference = yearDifference * 12 + monthDifference;

    if (monthDifference > 0 && to.day < from.day) {
      difference--;
    }

    return difference;
  }

  /// Initialize dates method
  void _initDates() {
    _cumputeMonthsCount();

    _generateDates();

    _singleDateSelect(
      widget.selectedSingleDate?.dateOnly,
      triggerCallback: false,
    );

    _fillSelectedDates(
      widget.selectedDates ?? const [],
      triggerCallback: false,
    );

    _selectFullDateRange(
      widget.dateRange?.startDate?.dateOnly,
      widget.dateRange?.endDate?.dateOnly,
      triggerCallback: false,
    );

    _initialDate = widget.initialDate?.dateOnly;
  }

  /// Generate displayable dates method
  void _generateDates() {
    _dates = [];

    int year = widget.minDate.year;
    int currentMonth = widget.minDate.month;

    for (int i = 0; i <= _monthCount; i++) {
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

  void _initScrollController() {
    _scrollController = widget.scrollController ?? ScrollController();
    _listController = ListController();
  }

  void _fillSelectedDates(
    List<DateTime> dates, {
    bool triggerCallback = true,
  }) {
    for (final date in dates) {
      _addSelectedDate(
        date.dateOnly,
        triggerCallback: triggerCallback && date == dates.last,
      );
    }
  }

  /// Init method
  void _init() => setState(
        () {
          _initDates();
          _initScrollController();
          _scrollToInitialDate();
        },
      );

  /// Scroll to [_initialDate] method
  void _scrollToInitialDate() {
    if (_initialDate is! DateTime) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _listController.jumpToItem(
        index: _dates.indexOf(
          _initialDate!.copyWith(day: 1),
        ),
        scrollController: _scrollController,
        alignment: 0,
      ),
    );
  }

  /// Clear [_selectedSingleDate] method
  void _clearSingleDate() => _selectedSingleDate = null;

  /// Clear [_dateRange] method
  void _clearDateRange() => _dateRange = null;

  /// Clear [_selectedDates] method
  void _clearSelectedDates() => _selectedDates.clear();

  /// Clear [_selectedSingleDate], [_selectedDates], [_dateRange] method
  void _clearDates() {
    _clearSingleDate();
    _clearDateRange();
    _clearSelectedDates();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.onDateSelect?.call(null, null, null),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  bool _selectedDatesEqual(
    List<DateTime>? a,
    List<DateTime>? b,
  ) {
    if (a == null) {
      return b == null;
    }
    if (b == null || a.length != b.length) {
      return false;
    }
    if (identical(a, b)) {
      return true;
    }
    for (int index = 0; index < a.length; index += 1) {
      if (a[index].dateOnly != b[index].dateOnly) {
        return false;
      }
    }

    return true;
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(covariant ScrollableDatePicker oldWidget) {
    if (oldWidget.dateSelectionType != widget.dateSelectionType ||
        oldWidget.futureDatesAreAvailable != widget.futureDatesAreAvailable) {
      _clearDates();
    }

    if (oldWidget.selectedSingleDate?.dateOnly !=
        widget.selectedSingleDate?.dateOnly) {
      widget.selectedSingleDate is! DateTime
          ? _clearSingleDate()
          : _selectedSingleDate = widget.selectedSingleDate?.dateOnly;
    }

    if (!_selectedDatesEqual(oldWidget.selectedDates, widget.selectedDates)) {
      _clearSelectedDates();
      if (widget.selectedDates is! List<DateTime>) {
        return;
      } else {
        _fillSelectedDates(
          widget.selectedDates!,
          triggerCallback: false,
        );
      }
    }

    if (oldWidget.dateRange != widget.dateRange) {
      widget.dateRange is! DateRangeModel
          ? _clearDateRange()
          : _selectFullDateRange(
              widget.dateRange?.startDate,
              widget.dateRange?.endDate,
              triggerCallback: false,
            );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SuperListView.builder(
        itemCount: _dates.length,
        controller: _scrollController,
        listController: _listController,
        padding: widget.datePickerPadding,
        itemBuilder: (context, index) => Column(
          children: [
            if (widget.showHeaderTitle)
              widget.headerBuilder is HeaderBuilder
                  ? widget.headerBuilder!(
                      context,
                      _dates[index],
                      _onHeaderTap,
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                        widget.headerPadding.left,
                        index == 0 ? 0 : widget.headerPadding.top,
                        widget.headerPadding.right,
                        index == _dates.length - 1
                            ? 0
                            : widget.headerPadding.bottom,
                      ),
                      child: Header(
                        headerColor: anyDateInMonthSelected(_dates[index])
                            ? widget.headerColor
                            : null,
                        onTap: () => _onHeaderTap(
                          _dates[index],
                        ),
                        title: widget.headerDateFormat?.format(_dates[index]) ??
                            DateFormat(
                              "MMMM${_dates[index].year != _dateTimeNow.year ? ", ${_dates[index].year}" : ""}",
                              widget.localeName,
                            ).format(_dates[index]),
                        disabled: !widget.futureDatesAreAvailable &&
                            _dates[index].isAfter(_dateTimeNow),
                        textStyle: widget.headerTextStyle,
                        headerDecoration: widget.headerDecoration,
                      ),
                    ),
            Padding(
              padding: widget.monthViewPadding,
              child: SizedBox(
                height: widget.monthViewHeight,
                width: widget.monthViewWidth,
                child: DaysViewLeafRenderObjectWidget(
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
                  weekdaysNameTextStyle: widget.weekdaysNameTextStyle,
                  weekendDaysNumberTextStyle: widget.weekendDaysTextStyle,
                  weekendDaysNameTextStyle: widget.weekendDaysNameTextStyle,
                  currentDateTextStyle: widget.currentDateTextStyle,
                  futureDatesTextStyle: widget.futureDatesTextStyle,
                  dayNumberTextStyle: widget.dayNumberTextStyle,
                  onDateSelect: _onDateSelect,
                  localeName: widget.localeName,
                  dateSelectionType: widget.dateSelectionType,
                  selectedSingleDate: _selectedSingleDate,
                  selectedDates: _selectedDates,
                  dateRange: _dateRange,
                  futureDatesAreAvailable: widget.futureDatesAreAvailable,
                  singleSelectionDecoration: widget.singleSelectionDecoration,
                  rangeSelectionDecoration: widget.rangeSelectionDecoration,
                  daysRowHeight: widget.daysRowHeight,
                ),
              ),
            ),
          ],
        ),
      );
}
