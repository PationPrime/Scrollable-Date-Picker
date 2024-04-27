part of 'days_view_leaf_render_object_widget.dart';

class DaysViewRenderBox extends RenderBox {
  /// Minimum reserved width.
  static const _minDesiredWidth = 0.0;

  /// Minimum reserved height.
  static const _minDesiredHeight = 0.0;

  /// Date now without time.
  final _dateTimeNow = DateTime.now().dateOnly;

  /// View date.
  late DateTime _viewDate;
  DateTime get viewDate => _viewDate;

  set viewDate(DateTime date) {
    if (_viewDate == date) return;
    _viewDate = date;
    markNeedsPaint();
  }

  /// Count of days in month.
  late int _daysCount;
  int get daysCount => _daysCount;

  set daysCount(int value) {
    if (daysCount == value) return;
    _daysCount = value;
    markNeedsLayout();
    markNeedsPaint();
  }

  /// First date weekday number (from 1 (Monday) to 7 (Sunday)).
  late int _startWeekday;
  int get startWeekday => _startWeekday;

  set startWeekday(int value) {
    if (startWeekday == value) return;
    _startWeekday = value;
    markNeedsPaint();
  }

  late bool _betweenDates;
  bool get betweenDates => _betweenDates;

  set betweenDates(bool value) {
    if (_betweenDates == value) return;
    _betweenDates = value;
    markNeedsPaint();
  }

  late bool _showWeekdays;
  bool get showWeekdays => _showWeekdays;

  set showWeekdays(bool value) {
    if (value == _showWeekdays) return;
    _showWeekdays = value;
    markNeedsPaint();
  }

  TextStyle? _weekdaysNameStyle;
  TextStyle? get weekdayTextStyle => _weekdaysNameStyle;

  set weekdayTextStyle(TextStyle? style) {
    if (_weekdaysNameStyle == style) return;
    _weekdaysNameStyle = style;
    markNeedsPaint();
  }

  TextStyle? _dayNumberTextStyle;
  TextStyle? get dayNumberTextStyle => _dayNumberTextStyle;

  set dayNumberTextStyle(TextStyle? style) {
    if (_dayNumberTextStyle == style) return;
    _dayNumberTextStyle = style;
    markNeedsLayout();
    markNeedsPaint();
  }

  late SingleSelectionDecoration _singleSelectionDecoration;
  SingleSelectionDecoration get singleSelectionDecoration =>
      _singleSelectionDecoration;

  set singleSelectionDecoration(SingleSelectionDecoration decoration) {
    if (_singleSelectionDecoration == decoration) return;
    _singleSelectionDecoration = decoration;
    markNeedsLayout();
    markNeedsPaint();
  }

  late RangeSelectionDecoration _rangeSelectionDecoration;
  RangeSelectionDecoration get rangeSelectionDecoration =>
      _rangeSelectionDecoration;

  set rangeSelectionDecoration(RangeSelectionDecoration decoration) {
    if (_rangeSelectionDecoration == decoration) return;
    _rangeSelectionDecoration = decoration;
    markNeedsLayout();
    markNeedsPaint();
  }

  late TextStyle _currentDateTextStyle;
  TextStyle get currentDateTextStyle => _currentDateTextStyle;

  set currentDateTextStyle(TextStyle style) {
    if (_currentDateTextStyle == style) return;
    _currentDateTextStyle = style;
    markNeedsPaint();
  }

  TextStyle? _futureDatesTextStyle;
  TextStyle? get futureDatesTextStyle => _futureDatesTextStyle;

  set futureDatesTextStyle(TextStyle? style) {
    if (_futureDatesTextStyle == style) return;
    _futureDatesTextStyle = style;
    markNeedsPaint();
  }

  TextStyle? _weekendDaysTextStyle;
  TextStyle? get weekendDaysTextStyle => _weekendDaysTextStyle;

  set weekendDaysTextStyle(TextStyle? style) {
    if (_weekendDaysTextStyle == style) return;
    _weekendDaysTextStyle = style;
    markNeedsPaint();
  }

  TextStyle? _weekendDaysNameTextStyle;
  TextStyle? get weekendDaysNameTextStyle => _weekendDaysNameTextStyle;

  set weekendDaysNameTextStyle(TextStyle? style) {
    if (_weekendDaysNameTextStyle == style) return;
    _weekendDaysNameTextStyle = style;
    markNeedsPaint();
  }

  late List<DayViewModel> _currentMonthDays;

  /// Generate dates belonging to a month method.
  void _generateCurrentMonthDays() => _currentMonthDays = [
        for (int i = 1; i <= daysCount; i++)
          DayViewModel(
            number: i,
            date: viewDate.copyWith(day: i),
            monthViewOwnerDate: viewDate,
          ),
      ];

  /// Gesture recognition.
  late TapGestureRecognizer onTap;

  /// Initialize on tap up gesture callback method.
  void _initOnTapUp() => onTap = TapGestureRecognizer()
    ..onTapUp = (
      TapUpDetails tapDownDetails,
    ) =>
        _onTapUp(tapDownDetails);

  /// Find tapped day method.
  DayViewModel? _findTappedDay(TapUpDetails tapDownDetails) {
    try {
      return _currentMonthDays.firstWhere(
        (day) => day.rect?.contains(tapDownDetails.localPosition) ?? false,
      );
    } catch (_) {
      return null;
    }
  }

  /// onTapUp implementation.
  void _onTapUp(TapUpDetails tapUpDetails) {
    final tappedDay = _findTappedDay(tapUpDetails);

    if (tappedDay is! DayViewModel) {
      return;
    }

    _onDateTap(tappedDay);
  }

  late Function(DateTime?)? _onDateSelect;
  Function(DateTime?)? get onDateSelect => _onDateSelect;

  set onDateSelect(Function(DateTime?)? function) {
    if (_onDateSelect == function) return;
    _onDateSelect = function;
  }

  String? _localeName;
  String? get localeName => _localeName;

  set localeName(String? name) {
    if (_localeName == name) return;
    _localeName = name;
    markNeedsPaint();
  }

  late DateSelectionType _dateSelectionType;
  DateSelectionType get dateSelectionType => _dateSelectionType;

  set dateSelectionType(DateSelectionType selectionType) {
    if (_dateSelectionType == selectionType) return;
    _dateSelectionType = selectionType;
    markNeedsPaint();
  }

  DateTime? _selectedSingleDate;
  DateTime? get selectedSingleDate => _selectedSingleDate;

  set selectedSingleDate(DateTime? date) {
    if (_selectedSingleDate == date) return;
    _selectedSingleDate = date;
    markNeedsPaint();
    markNeedsLayout();
  }

  late List<DateTime> _selectedDates;
  List<DateTime> get selectedDates => _selectedDates;

  set selectedDates(List<DateTime> dates) {
    _selectedDates = dates;
    markNeedsPaint();
    markNeedsLayout();
  }

  DateRangeModel? _dateRange;
  DateRangeModel? get dateRange => _dateRange;

  set dateRange(DateRangeModel? range) {
    if (_dateRange == range) return;
    _dateRange = range;
    markNeedsLayout();
    markNeedsPaint();
  }

  late bool _futureDatesAreAvailable;
  bool get futureDatesAreAvailable => _futureDatesAreAvailable;

  set futureDatesAreAvailable(bool value) {
    if (_futureDatesAreAvailable == value) return;
    _futureDatesAreAvailable = value;
    markNeedsPaint();
  }

  late double _daysRowHeight;
  double get daysRowHeight => _daysRowHeight;

  set daysRowHeight(double value) {
    if (_daysRowHeight == value) return;
    _daysRowHeight = value;
    markNeedsPaint();
  }

  /// Check if day is inside [dateRange] method.
  bool _dayIsInsideDateRange(DayViewModel day) =>
      dateRange is DateRangeModel &&
          dateRange?.startDate is DateTime &&
          dateRange?.endDate is DateTime &&
          day.date is DateTime &&
          day.date!.isAfter(dateRange!.startDate!) &&
          day.date!.isBefore(dateRange!.endDate!) ||
      day.date == dateRange?.startDate ||
      day.date == dateRange?.endDate;

  List<DayViewModel> get _daysInRange {
    final Set<DayViewModel> daysInRange = {};

    if (dateRange?.startDate is! DateTime || dateRange?.endDate is! DateTime) {
      return [];
    }

    for (final day in _currentMonthDays) {
      if (_dayIsInsideDateRange(day)) {
        daysInRange.add(day);
      }
    }

    return daysInRange.toList();
  }

  /// On date tap callback.
  void _onDateTap(DayViewModel tappedDay) {
    final date = viewDate.copyWith(
      day: tappedDay.number,
    );

    if (!futureDatesAreAvailable && date.isAfter(_dateTimeNow)) return;

    _onDateSelect?.call(date);
  }

  /// Gesture detection initialization method.
  void _initGestures() {
    _initOnTapUp();
  }

  DaysViewRenderBox({
    required int startWeekday,
    required int daysCount,
    required DateTime viewDate,
    required bool betweenDates,
    required bool showWeekdays,
    TextStyle? dayNumberTextStyle,
    TextStyle? weekdaysNameTextStyle,
    TextStyle? weekendDaysNumberStyle,
    TextStyle? weekendDaysNameTextStyle,
    required TextStyle currentDateTextStyle,
    TextStyle? futureDatesTextStyle,
    String? localeName,
    required DateSelectionType dateSelectionType,
    DateTime? selectedSingleDate,
    required List<DateTime> selectedDates,
    DateRangeModel? dateRange,
    void Function(DateTime?)? onDateSelect,
    required bool futureDatesAreAvailable,
    required SingleSelectionDecoration singleSelectionDecoration,
    required RangeSelectionDecoration rangeSelectionDecoration,
    required double daysRowHeight,
  })  : _startWeekday = startWeekday,
        _daysCount = daysCount,
        _viewDate = viewDate,
        _betweenDates = betweenDates,
        _showWeekdays = showWeekdays,
        _weekdaysNameStyle = weekdaysNameTextStyle,
        _dayNumberTextStyle = dayNumberTextStyle,
        _weekendDaysTextStyle = weekendDaysNumberStyle,
        _weekendDaysNameTextStyle = weekendDaysNameTextStyle,
        _currentDateTextStyle = currentDateTextStyle,
        _futureDatesTextStyle = futureDatesTextStyle,
        _localeName = localeName,
        _dateSelectionType = dateSelectionType,
        _selectedSingleDate = selectedSingleDate,
        _selectedDates = selectedDates,
        _dateRange = dateRange,
        _onDateSelect = onDateSelect,
        _futureDatesAreAvailable = futureDatesAreAvailable,
        _singleSelectionDecoration = singleSelectionDecoration,
        _rangeSelectionDecoration = rangeSelectionDecoration,
        _daysRowHeight = daysRowHeight {
    _generateCurrentMonthDays();
    _initGestures();
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));

    if (event is PointerDownEvent) {
      /// Pointer register.
      onTap.addPointer(event);
    }
  }

  /// Getter, which returns displaying rows count.
  /// If [showWeekdays] == true, add 1 to rows count,
  /// which reserved to paint weekday names.
  int get _rowsCount =>
      ((daysCount + startWeekday - 1) / 7).ceil() + (showWeekdays ? 1 : 0);

  double get _rowHeight => _desiredHeight / _rowsCount;

  double get _dayCellWidth => size.width / 7;

  double get _desiredHeight => _rowsCount * daysRowHeight;

  /// Method, which returns instance of [TextPainter].
  TextPainter _dayNumberPainer(
    int number, {
    TextStyle? textStyle,
  }) =>
      TextPainter(
        text: TextSpan(
          text: "$number",
          style: textStyle,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

  /// Method, which returns instance of [TextStyle] depends on:
  /// 1. [SelectionDecoration] configuration;
  /// 2. Is date selected;
  /// 3. Is date current date;
  /// 4. Future dates available [futureDatesAreAvailable] flag;
  /// 5. Is date weekend date;
  TextStyle? _dayNumberPainterTextStyle(
    DayViewModel day,
  ) {
    final decoration = dateSelectionType.isDateRange
        ? rangeSelectionDecoration
        : singleSelectionDecoration;

    final selected = _dayIsInsideDateRange(day) ||
        selectedDates.any((date) => date == day.date!) ||
        selectedSingleDate == day.date;

    if (selected) {
      return decoration.selectedDateTextStyle;
    } else if (day.date == _dateTimeNow) {
      return currentDateTextStyle;
    } else if (!futureDatesAreAvailable && day.date!.isAfter(_dateTimeNow)) {
      return futureDatesTextStyle;
    } else if (day.date?.weekday == 6 || day.date?.weekday == 7) {
      return weekendDaysTextStyle;
    }

    return dayNumberTextStyle;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredSize = Size(desiredWidth, _desiredHeight);

    return constraints.constrain(desiredSize);
  }

  /// Days layout method.
  /// Mainly Needs to compute day number and day rect positions.
  void _layoutDays(
    Offset position,
    double dxStep,
    double dyStep,
    List<DayViewModel> days, {
    bool updateDYPosition = true,
  }) {
    for (int i = 0; i < days.length; i++) {
      final day = days[i].copyWith(
        selectionCenter: position,
        rect: Rect.fromCenter(
          center: position,
          width: dxStep,
          height: dyStep,
        ),
      );

      final nextDayWeekday = day.date?.copyWith(day: day.number + 1).weekday;

      final textStyle = _dayNumberPainterTextStyle(
        day,
      );

      final painter = _dayNumberPainer(
        day.number,
        textStyle: textStyle,
      );

      painter.layout();

      final dayNumberCenter = Offset(
        position.dx - painter.size.width / 2,
        position.dy - painter.size.height / 2,
      );

      days.removeAt(i);

      days.insert(
        i,
        day.copyWith(
          dayNumberCenter: dayNumberCenter,
        ),
      );

      final dx = nextDayWeekday == 1 ? dxStep / 2 : position.dx + dxStep;
      final dy = !updateDYPosition
          ? position.dy
          : nextDayWeekday == 1
              ? position.dy + dyStep
              : position.dy;

      position = Offset(dx, dy);
    }
  }

  void _layoutCurrentMonthDays() {
    final dayStepDX = _dayCellWidth;
    final dayStepDY = _rowHeight;

    final initialDX = (startWeekday - 1) * dayStepDX + dayStepDX / 2;
    final initialDY = dayStepDY / 2 + (showWeekdays ? dayStepDY : 0);

    Offset position = Offset(
      initialDX,
      initialDY,
    );
    _layoutDays(
      position,
      dayStepDX,
      dayStepDY,
      _currentMonthDays,
    );
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
    _layoutCurrentMonthDays();
  }

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMinIntrinsicHeight(double width) => _minDesiredHeight;
  @override
  double computeMaxIntrinsicHeight(double width) => _desiredHeight;

  /// Weekdays painting method.
  void _paintWeekdays(Canvas canvas) {
    if (!showWeekdays) {
      return;
    }

    final dayStepDX = _dayCellWidth;
    final dayStepDY = _rowHeight;

    Offset position = Offset(
      dayStepDX / 2,
      dayStepDY / 2,
    );

    final weekdayNames = ViewConstants.shortWeekdayNamesFromMonday(
      localeName: localeName,
    );

    for (int i = 0; i < weekdayNames.length; i++) {
      final painter = TextPainter(
        text: TextSpan(
          text: weekdayNames[i],
          style: i == 5 || i == 6 ? weekendDaysNameTextStyle : weekdayTextStyle,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      painter.layout();

      final dayNumberCenter = Offset(
        position.dx - painter.size.width / 2,
        position.dy - painter.size.height / 2,
      );

      painter.paint(
        canvas,
        dayNumberCenter,
      );

      final dx = position.dx + dayStepDX;

      position = Offset(dx, position.dy);
    }
  }

  /// Day numbers painting method.
  void _paintDays(
    Canvas canvas,
    List<DayViewModel> days, {
    TextStyle? textStyle,
  }) {
    for (final day in days) {
      final painter = _dayNumberPainer(
        day.number,
        textStyle: textStyle ??
            _dayNumberPainterTextStyle(
              day,
            ),
      );

      painter.layout();

      painter.paint(
        canvas,
        day.dayNumberCenter!,
      );
    }
  }

  /// Method, which creates RRect from Rect with decoration (borderRadius).
  RRect _rectToRRect(
    Rect rect,
    SelectionDecoration decoration,
  ) {
    rect = Rect.fromCenter(
      center: rect.center,
      width: _dayCellWidth,
      height: (decoration.height ?? _rowHeight).clamp(0, _rowHeight),
    );

    return RRect.fromRectAndCorners(
      rect,
      topLeft: decoration.borderRadius.topLeft,
      topRight: decoration.borderRadius.topRight,
      bottomLeft: decoration.borderRadius.bottomLeft,
      bottomRight: decoration.borderRadius.bottomRight,
    );
  }

  /// Rectangle single selection drawind method.
  void _drawSingleRectSelection(
    Canvas canvas,
    DayViewModel day, {
    SingleSelectionDecoration? decoration,
  }) {
    Rect? rect = day.rect;

    if (rect is! Rect) {
      return;
    }

    decoration ??= singleSelectionDecoration;

    if (decoration.height is double) {
      rect = Rect.fromCenter(
        center: Offset(
          day.selectionCenter!.dx,
          day.selectionCenter!.dy,
        ),
        width: _dayCellWidth,
        height: decoration.height!.clamp(
          0,
          _rowHeight,
        ),
      );
    }

    final rRect = _rectToRRect(
      rect,
      decoration,
    );

    canvas.drawRRect(
      rRect,
      Paint()..color = decoration.color,
    );
  }

  /// Circular single selection drawind method.
  void _drawSingleCircleSelection(
    Canvas canvas,
    Offset center, {
    SingleSelectionDecoration? decoration,
  }) {
    decoration ??= singleSelectionDecoration;

    final radius = (decoration.width ??
            decoration.height ??
            singleSelectionDecoration.width ??
            singleSelectionDecoration.height ??
            _desiredHeight / (_rowsCount - 1))
        .clamp(
      0.0,
      _desiredHeight / (2 * (_rowsCount - 1)),
    );

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = decoration.color,
    );
  }

  /// Rectangle single selection painting method.
  void _paintSingleRectSelection(
    Canvas canvas, {
    DateTime? date,
    SingleSelectionDecoration? decoration,
  }) {
    DayViewModel? dayModel;

    if (date is! DateTime) {
      date = _selectedSingleDate;
    }

    try {
      dayModel = _currentMonthDays.firstWhere((day) => day.date == date);
    } catch (_) {
      dayModel = null;
    }

    if (dayModel is! DayViewModel) {
      return;
    }

    _drawSingleRectSelection(
      canvas,
      dayModel,
      decoration: decoration,
    );
  }

  /// Circular single selection painting method.
  void _paintSingleCircleSelection(
    Canvas canvas, {
    DateTime? date,
    SingleSelectionDecoration? decoration,
  }) {
    Offset? center;

    if (date is! DateTime) {
      date = _selectedSingleDate;
    }

    try {
      center = _currentMonthDays
          .firstWhere((day) => day.date == date)
          .selectionCenter;
    } catch (_) {
      center = null;
    }

    if (center is! Offset) {
      return;
    }

    _drawSingleCircleSelection(
      canvas,
      center,
      decoration: decoration,
    );
  }

  /// Single selection painting method.
  /// Painting shape depends on decoration.
  void _paintSingleSelection(
    Canvas canvas, {
    DateTime? date,
    SingleSelectionDecoration? decoration,
  }) {
    switch (decoration?.shape ?? singleSelectionDecoration.shape) {
      case BoxShape.rectangle:
        _paintSingleRectSelection(
          canvas,
          date: date,
          decoration: decoration,
        );

      case BoxShape.circle:
        _paintSingleCircleSelection(
          canvas,
          date: date,
          decoration: decoration,
        );
    }
  }

  /// Range selection painting method.
  void _paintRangeSelection(Canvas canvas) {
    if (dateRange?.startDate is DateTime && dateRange?.endDate is DateTime) {
      _paintSelectionBetweenDateRange(
        canvas,
      );
    }

    if (dateRange?.startDate is! DateTime) {
      return;
    }

    _paintSingleSelection(
      canvas,
      date: dateRange?.startDate,
      decoration: rangeSelectionDecoration.startDateSelectionDecoration,
    );

    if (dateRange?.endDate is! DateTime) {
      return;
    }

    _paintSingleSelection(
      canvas,
      date: dateRange?.endDate,
      decoration: rangeSelectionDecoration.endDateSelectionDecoration,
    );
  }

  /// Strat and end date selection gap painting method.
  Path? _paintStartAndEndDateSelectionGap(
    Canvas canvas,
    DayViewModel day,
  ) {
    if (day == _daysInRange.first &&
            _currentMonthDays.any((day) => dateRange?.startDate == day.date) ||
        day == _daysInRange.last &&
            _currentMonthDays.any((day) => dateRange?.endDate == day.date)) {
      Rect? firstDayRect;

      final firstDayPath = Path();

      if (day == _daysInRange.first || day == _daysInRange.last) {
        if (rangeSelectionDecoration
                .startDateSelectionDecoration.shape.isCicle ||
            rangeSelectionDecoration
                    .startDateSelectionDecoration.borderRadius !=
                BorderRadius.zero ||
            rangeSelectionDecoration.endDateSelectionDecoration.shape.isCicle ||
            rangeSelectionDecoration.endDateSelectionDecoration.borderRadius !=
                BorderRadius.zero) {
          firstDayRect = Rect.fromCircle(
            center: day.selectionCenter!,
            radius: (day == _daysInRange.first
                    ? rangeSelectionDecoration
                            .startDateSelectionDecoration.width ??
                        rangeSelectionDecoration
                            .startDateSelectionDecoration.height
                    : rangeSelectionDecoration
                            .endDateSelectionDecoration.width ??
                        rangeSelectionDecoration
                            .startDateSelectionDecoration.height) ??
                size.height / 14,
          );

          firstDayPath.addOval(
            firstDayRect,
          );
        } else {
          firstDayPath.addRect(
            day.rect!,
          );
        }
      }

      final rect = Rect.fromCenter(
        center: Offset(
          day.selectionCenter!.dx,
          day.selectionCenter!.dy,
        ),
        width: _dayCellWidth,
        height: (rangeSelectionDecoration.height ?? _rowHeight)
            .clamp(0, _rowHeight),
      );

      final differencePath = Path.combine(
        PathOperation.reverseDifference,
        firstDayPath,
        Path()..addRect(rect),
      );

      final halfOfDifferenceRect = Rect.fromCenter(
        center: Offset(
          day.selectionCenter!.dx +
              (day == _daysInRange.first &&
                      _currentMonthDays
                          .any((day) => dateRange?.startDate == day.date)
                  ? -_dayCellWidth / 3
                  : _dayCellWidth / 3),
          day.selectionCenter!.dy,
        ),
        width: _dayCellWidth / 2,
        height: (rangeSelectionDecoration.height ?? _rowHeight)
            .clamp(0, _rowHeight),
      );

      final gapPath = Path.combine(
        PathOperation.difference,
        differencePath,
        Path()..addRect(halfOfDifferenceRect),
      );

      return gapPath;
    }

    return null;
  }

  /// Seleciton between date range painting method.
  /// Includes start and end dates selection painting,
  /// start and end dates gaps painting,
  /// selection painting between start and end dates.
  void _paintSelectionBetweenDateRange(Canvas canvas) {
    Path selectionPath = Path();
    Path? gapPath;

    for (final day in _daysInRange) {
      if (dateRange?.startDate != dateRange?.endDate) {
        gapPath = _paintStartAndEndDateSelectionGap(
          canvas,
          day,
        );
      }

      if (day.date != dateRange?.startDate && day.date != dateRange!.endDate) {
        ///
        BorderRadius borderRadius = BorderRadius.zero;

        if (day.date!.weekday == 1 && day == _daysInRange.last ||
            day.date!.weekday == 7 && day == _daysInRange.first) {
          borderRadius = rangeSelectionDecoration.borderRadius;
        } else if (day.date!.weekday == 1 ||
            day == _daysInRange.first ||
            day.date!.weekday == 7 && day == _currentMonthDays.first) {
          borderRadius = BorderRadius.horizontal(
            left: rangeSelectionDecoration.borderRadius.topLeft,
          );
        } else if (day.date!.weekday == 7 || day == _daysInRange.last) {
          borderRadius = BorderRadius.horizontal(
            right: rangeSelectionDecoration.borderRadius.topRight,
          );
        }

        final decoration = rangeSelectionDecoration.copyWith(
          borderRadius: borderRadius,
        );

        final rRect = _rectToRRect(
          day.rect!,
          decoration,
        );

        selectionPath.addRRect(rRect);
      }

      if (gapPath is Path) {
        selectionPath = Path.combine(
          PathOperation.union,
          selectionPath,
          gapPath,
        );
      }
    }

    canvas.drawPath(
      selectionPath,
      Paint()..color = rangeSelectionDecoration.color,
    );
  }

  /// Method, which paints selection for each date in [selectedDates].
  void _paintSelectedDates(Canvas canvas) {
    for (final date in selectedDates) {
      _paintSingleSelection(
        canvas,
        date: date,
      );
    }
  }

  /// Method, which paints selection depends on [DateSelectionType].
  void _paintDatesSelection(Canvas canvas) {
    switch (dateSelectionType) {
      case DateSelectionType.singleDate:
        _paintSingleSelection(canvas);
      case DateSelectionType.multipleDates:
        _paintSelectedDates(canvas);
      case DateSelectionType.dateRange:
        _paintRangeSelection(canvas);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _paintWeekdays(context.canvas);

    _paintDatesSelection(context.canvas);

    _paintDays(
      context.canvas,
      _currentMonthDays,
    );
  }
}
