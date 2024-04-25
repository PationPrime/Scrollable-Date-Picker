import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';
import 'package:scrollable_date_picker/src/rendering/rendering.dart';

typedef HeaderBuilder = Widget Function(
  BuildContext,
  DateTime,
  Function(DateTime),
);

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
  final TextStyle? currentDateTextStyle;

  /// Month day text style
  final TextStyle? dayNumberTextStyle;

  /// Previous month days text style
  final TextStyle previousMonthDayNumberTextStyle;

  /// Next month days text style
  final TextStyle nextMonthDayNumberTextStyle;

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

  /// Flag to display previous month days
  final bool showPreviousMonthDays;

  /// Flag to display next month days
  final bool showNextMonthDays;

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
    this.currentDateTextStyle,
    this.dayNumberTextStyle,
    this.previousMonthDayNumberTextStyle = const TextStyle(color: Colors.grey),
    this.nextMonthDayNumberTextStyle = const TextStyle(color: Colors.grey),
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
    this.showPreviousMonthDays = false,
    this.showNextMonthDays = false,
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
    this.daysRowHeight = 60.0,
    this.headerDecoration,
    this.headerBuilder,
    this.headerPadding = const EdgeInsets.symmetric(
      vertical: 20,
    ),
    this.datePickerPadding = const EdgeInsets.only(),
    this.monthViewPadding = const EdgeInsets.only(),
    this.monthViewHeight,
    this.monthViewWidth,
  }) : assert(
          minDate.isBefore(maxDate),
          "Minimum date cannot be after maximum date",
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
  List<DateTime> _selectedDates = [];

  final _dateTimeNow = DateTime.now().dateOnly;

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

      case DateSelectionType.multipleDates:
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
      setState(() {
        _dateRange = null;
      });
    }

    if (_dateRange?.startDate is! DateTime) {
      _startDateSelect(date);
    } else if (_dateRange?.endDate is! DateTime) {
      _endDateSelect(date);

      if (_dateRange!.endDate!.isBefore(_dateRange!.startDate!)) {
        _swapDatesInDateRange();
      }
    }

    if (triggerCallback) widget.onDateSelect?.call(null, null, _dateRange);
  }

  void _swapDatesInDateRange() {
    final firstDate = _dateRange!.endDate;
    final lastDate = _dateRange!.startDate;

    _startDateSelect(firstDate);
    _endDateSelect(lastDate);
  }

  void _singleDateSelect(DateTime? date) {
    setState(
      () => _selectedSingleDate = date,
    );

    widget.onDateSelect?.call(date, null, null);
  }

  void _startDateSelect(DateTime? date) => setState(
        () => _dateRange = DateRangeModel(
          startDate: date,
        ),
      );

  void _endDateSelect(DateTime? date) => setState(
        () => _dateRange = _dateRange?.copyWith(
          endDate: date,
        ),
      );

  void _addSelectedDate(
    DateTime date, {
    bool triggerCallback = true,
  }) {
    setState(
      () => _selectedDates.contains(date)
          ? _selectedDates.remove(date)
          : _selectedDates.add(date),
    );

    if (!triggerCallback) {
      return;
    }

    widget.onDateSelect?.call(
      null,
      _selectedDates,
      null,
    );
  }

  void _onHeaderTap(DateTime date) {
    switch (widget.dateSelectionType) {
      case DateSelectionType.singleDate:
        _singleDateSelect(date);

      case DateSelectionType.multipleDates:
        final lastDayInMonth = date.copyWith(day: 0, month: date.month + 1).day;

        if (_selectedDates.isNotEmpty) _clearSelectedDates();

        for (int day = 1; day <= lastDayInMonth; day++) {
          _addSelectedDate(
            date.copyWith(day: day),
            triggerCallback: day == lastDayInMonth,
          );
        }

      case DateSelectionType.dateRange:
        _clearDateRange();
        _selectDateRange(date, triggerCallback: false);
        _selectDateRange(date.copyWith(day: 0, month: date.month + 1));
    }
  }

  void _cumputeMonthsCount() {
    final yearDifference = widget.maxDate.year - widget.minDate.year + 1;
    _monthCount = yearDifference == 1 ? 12 : yearDifference * 12;
  }

  void _initDates() {
    _selectedSingleDate = widget.selectedSingleDate;

    _selectedDates.addAll(
      widget.selectedDates ?? [],
    );

    _dateRange = widget.dateRange;

    _initialDate = widget.initialDate ??
        (_dates.contains(_dateTimeNow) ? _dateTimeNow : null);
  }

  void _initScrollController() =>
      _scrollController = widget.scrollController ?? ScrollController();

  void _init() => setState(
        () {
          _cumputeMonthsCount();
          _generateDates();
          _initDates();
          _initScrollController();
        },
      );

  void _clearSingleDate() => _selectedSingleDate = null;

  void _clearDateRange() => _dateRange = null;

  void _clearSelectedDates() => _selectedDates.clear();

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

  @override
  void didUpdateWidget(covariant ScrollableDatePicker oldWidget) {
    if (oldWidget.minDate != widget.minDate ||
        oldWidget.maxDate != widget.maxDate) {
      setState(
        () => _generateDates(),
      );
    }

    if (oldWidget.dateSelectionType != widget.dateSelectionType) {
      _clearDates();
    }

    if (oldWidget.selectedSingleDate != widget.selectedSingleDate) {
      widget.selectedSingleDate is! DateTime
          ? _clearSingleDate()
          : _selectedSingleDate = widget.selectedSingleDate;
    }

    if (oldWidget.selectedDates != widget.selectedDates) {
      widget.selectedDates is! List<DateTime>
          ? _clearSelectedDates()
          : _selectedDates = widget.selectedDates!;
    }

    if (oldWidget.dateRange != widget.dateRange) {
      widget.dateRange is! DateRangeModel
          ? _clearDateRange()
          : _dateRange = widget.dateRange;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: widget.datePickerPadding,
        itemExtent: widget.itemExtent,
        controller: _scrollController,
        physics: widget.scrollPhysics,
        itemCount: _dates.length,
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
                        onTap: () => _onHeaderTap(
                          _dates[index],
                        ),
                        title: widget.headerDateFormat?.format(_dates[index]) ??
                            DateFormat(
                              "MMMM${_dates[index].year != _dateTimeNow.year ? ", ${_dates[index].year}" : ""}",
                            ).format(_dates[index]),
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
                  previousMonthDayNumberTextStyle:
                      widget.previousMonthDayNumberTextStyle,
                  nextMonthDayNumberTextStyle:
                      widget.nextMonthDayNumberTextStyle,
                  onDateSelect: _onDateSelect,
                  localeName: widget.localeName,
                  dateSelectionType: widget.dateSelectionType,
                  selectedSingleDate: _selectedSingleDate,
                  selectedDates: _selectedDates,
                  dateRange: _dateRange,
                  showPreviousMonthDays: widget.showPreviousMonthDays,
                  showNextMonthDays: widget.showNextMonthDays,
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
