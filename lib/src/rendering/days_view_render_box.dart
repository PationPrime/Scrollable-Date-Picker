part of 'days_view_leaf_render_object_widget.dart';

class DaysViewRenderBox extends RenderBox {
  final _dateTimeNow = DateTime.now().dateOnly;

  /// view date
  late DateTime _viewDate;
  DateTime get viewDate => _viewDate;

  set viewDate(DateTime date) {
    if (_viewDate == date) return;
    _viewDate = date;
    markNeedsPaint();
  }

  /// Count of days in month
  late int _daysCount;
  int get daysCount => _daysCount;

  set daysCount(int value) {
    if (daysCount == value) return;
    _daysCount = value;
    markNeedsPaint();
  }

  /// First date weekday number (from 1 (Monday) to 7 (Sunday))
  late int _startWeekday;
  int get startWeekday => _startWeekday;

  set startWeekday(int value) {
    if (startWeekday == value) return;
    _startWeekday = value;
    markNeedsPaint();
  }

  /// First date weekday number (from 1 (Monday) to 7 (Sunday))
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

  TextStyle? _currentDateTextStyle;
  TextStyle? get currentDateTextStyle => _currentDateTextStyle;

  set currentDateTextStyle(TextStyle? style) {
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

  late TextStyle _previousMonthDayNumberTextStyle;
  TextStyle get previousMonthDayNumberTextStyle =>
      _previousMonthDayNumberTextStyle;

  set previousMonthDayNumberTextStyle(TextStyle style) {
    if (_previousMonthDayNumberTextStyle == style) return;
    _previousMonthDayNumberTextStyle = style;
    markNeedsPaint();
  }

  late TextStyle _nextMonthDayNumberTextStyle;
  TextStyle get nextMonthDayNumberTextStyle => _nextMonthDayNumberTextStyle;

  set nextMonthDayNumberTextStyle(TextStyle style) {
    if (_nextMonthDayNumberTextStyle == style) return;
    _nextMonthDayNumberTextStyle = style;
    markNeedsPaint();
  }

  late List<DayViewModel> _currentMonthDays;

  void _generateCurrentMonthDays() => _currentMonthDays = [
        for (int i = 1; i <= daysCount; i++)
          DayViewModel(
            number: i,
            date: viewDate.copyWith(day: i),
            monthViewOwnerDate: viewDate,
          ),
      ];

  late List<DayViewModel> _previousMonthVisibleDays;

  void _generatePreviousMonthVisibleDays() {
    final previousMonthVisibleDaysCount = viewDate.weekday - 2;

    if (!showPreviousMonthDays || previousMonthVisibleDaysCount == 0) {
      _previousMonthVisibleDays = [];
    }

    _previousMonthVisibleDays = [
      for (int i = previousMonthVisibleDaysCount; i >= 0; i--)
        DayViewModel(
          number: viewDate.copyWith(day: 0).day - i,
          date: viewDate.copyWith(
            month: viewDate.month - 1,
            day: viewDate.copyWith(day: 0).day - i,
          ),
          monthViewOwnerDate: viewDate,
        ),
    ];
  }

  late List<DayViewModel> _nextMonthVisibleDays;

  void _generateNextMonthVisibleDays() {
    final nextMonthVisibleDaysCount = 7 -
        viewDate
            .copyWith(
              month: viewDate.month + 1,
            )
            .weekday;

    if (!showNextMonthDays || nextMonthVisibleDaysCount == 0) {
      _nextMonthVisibleDays = [];
    }

    _nextMonthVisibleDays = [
      for (int i = 0; i < nextMonthVisibleDaysCount + 1; i++)
        DayViewModel(
          number: viewDate.copyWith(month: viewDate.month + 1).day + i,
          date: viewDate.copyWith(
            month: viewDate.month + 1,
            day: viewDate.copyWith(month: viewDate.month + 1).day + i,
          ),
          monthViewOwnerDate: viewDate,
        )
    ];
  }

  late TapGestureRecognizer onTap;
  late VerticalDragGestureRecognizer onDrag;

  void _initOnTapUp() => onTap = TapGestureRecognizer()
    ..onTapUp = (
      TapUpDetails tapDownDetails,
    ) =>
        _onTapUp(tapDownDetails);

  void _initDragStart() => onDrag = VerticalDragGestureRecognizer()
    ..onStart = (
      DragStartDetails dragStartDetails,
    ) {};

  DayViewModel? _findTappedDay(TapUpDetails tapDownDetails) {
    try {
      return _currentMonthDays.firstWhere(
        (day) => day.rect?.contains(tapDownDetails.localPosition) ?? false,
      );
    } catch (e) {
      return null;
    }
  }

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

  late bool _showPreviousMonthDays;
  bool get showPreviousMonthDays => _showPreviousMonthDays;

  set showPreviousMonthDays(bool value) {
    if (_showPreviousMonthDays == value) return;
    _showPreviousMonthDays = value;
    markNeedsPaint();
  }

  late bool _showNextMonthDays;
  bool get showNextMonthDays => _showNextMonthDays;

  set showNextMonthDays(bool value) {
    if (_showNextMonthDays == value) return;
    _showNextMonthDays = value;
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

    if (showPreviousMonthDays) {
      for (final previousMonthDay in _previousMonthVisibleDays) {
        if (_dayIsInsideDateRange(previousMonthDay)) {
          daysInRange.add(previousMonthDay);
        }
      }
    }

    for (final day in _currentMonthDays) {
      if (_dayIsInsideDateRange(day)) {
        daysInRange.add(day);
      }
    }

    if (showNextMonthDays) {
      for (final nextMonthDay in _nextMonthVisibleDays) {
        if (_dayIsInsideDateRange(nextMonthDay)) {
          daysInRange.add(nextMonthDay);
        }
      }
    }

    return daysInRange.toList();
  }

  void _onDateTap(DayViewModel tappedDay) {
    final date = viewDate.copyWith(
      day: tappedDay.number,
    );

    if (!futureDatesAreAvailable && date.isAfter(_dateTimeNow)) return;

    _onDateSelect?.call(date);
  }

  void _initGestures() {
    _initOnTapUp();
    _initDragStart();
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
    TextStyle? currentDateTextStyle,
    TextStyle? futureDatesTextStyle,
    required TextStyle previousMonthDayNumberTextStyle,
    required TextStyle nextMonthDayNumberTextStyle,
    String? localeName,
    required DateSelectionType dateSelectionType,
    DateTime? selectedSingleDate,
    required List<DateTime> selectedDates,
    DateRangeModel? dateRange,
    void Function(DateTime?)? onDateSelect,
    required bool showPreviousMonthDays,
    required bool showNextMonthDays,
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
        _previousMonthDayNumberTextStyle = previousMonthDayNumberTextStyle,
        _nextMonthDayNumberTextStyle = nextMonthDayNumberTextStyle,
        _localeName = localeName,
        _dateSelectionType = dateSelectionType,
        _selectedSingleDate = selectedSingleDate,
        _selectedDates = selectedDates,
        _dateRange = dateRange,
        _onDateSelect = onDateSelect,
        _showPreviousMonthDays = showPreviousMonthDays,
        _showNextMonthDays = showNextMonthDays,
        _futureDatesAreAvailable = futureDatesAreAvailable,
        _singleSelectionDecoration = singleSelectionDecoration,
        _rangeSelectionDecoration = rangeSelectionDecoration,
        _daysRowHeight = daysRowHeight {
    _generateCurrentMonthDays();
    _generatePreviousMonthVisibleDays();
    _generateNextMonthVisibleDays();
    _initGestures();
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  bool hitTestSelf(Offset position) => true;

  bool _isPointerMoving = false;
  bool get isPointerMoving => _isPointerMoving;

  set isPointerMoving(bool value) {
    if (_isPointerMoving == value) return;
    _isPointerMoving = value;
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));

    if (event is PointerDownEvent) {
      // isPointerMoving = false;
      onTap.addPointer(event);
    }

    if (event is PointerMoveEvent) {
      // isPointerMoving = true;
    }

    if (event is PointerUpEvent) {
      // onTap.handlePrimaryPointer(event);
    }
  }

  static const _minDesiredWidth = 0.0;
  static const _minDesiredHeight = 0.0;

  int get _rowsCount =>
      ((daysCount + startWeekday - 1) / 7).ceil() + (showWeekdays ? 1 : 0);

  double get _rowHeight => _desiredHeight / _rowsCount;

  double get _dayCellWidth => size.width / 7;

  double get _desiredHeight => _rowsCount * daysRowHeight;

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
    } else if (day.date?.weekday == 6 || day.date?.weekday == 7) {
      return weekendDaysTextStyle;
    } else if (!futureDatesAreAvailable && day.date!.isAfter(_dateTimeNow)) {
      return futureDatesTextStyle;
    }

    return dayNumberTextStyle;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredSize = Size(desiredWidth, _desiredHeight);

    return constraints.constrain(desiredSize);
  }

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

  void _layoutPreviousMonthDays() {
    if (!showPreviousMonthDays || _previousMonthVisibleDays.isEmpty) {
      return;
    }

    final dayStepDX = _dayCellWidth;
    final dayStepDY = _rowHeight;

    final initialDX = dayStepDX / 2;
    final initialDY = dayStepDY / 2 + (showWeekdays ? dayStepDY : 0);

    Offset position = Offset(
      initialDX,
      initialDY,
    );

    _layoutDays(
      position,
      dayStepDX,
      dayStepDY,
      _previousMonthVisibleDays,
    );
  }

  void _layoutNextMonthDays() {
    if (!showNextMonthDays || _nextMonthVisibleDays.isEmpty) {
      return;
    }

    final dayStepDX = _dayCellWidth;
    final dayStepDY = _rowHeight;

    final lastdayWeekday =
        viewDate.copyWith(month: viewDate.month + 1, day: 0).weekday;

    final initialDX = lastdayWeekday * dayStepDX + dayStepDX / 2;
    final initialDY =
        _rowHeight * _rowsCount - (showWeekdays ? _rowHeight / 2 : 0);

    Offset position = Offset(
      initialDX,
      initialDY,
    );

    _layoutDays(
      position,
      dayStepDX,
      dayStepDY,
      _nextMonthVisibleDays,
      updateDYPosition: false,
    );
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
    _layoutPreviousMonthDays();
    _layoutCurrentMonthDays();
    _layoutNextMonthDays();
  }

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMinIntrinsicHeight(double width) => _minDesiredHeight;
  @override
  double computeMaxIntrinsicHeight(double width) => _desiredHeight;

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

  void _paintSelectedDates(Canvas canvas) {
    for (final date in selectedDates) {
      _paintSingleSelection(
        canvas,
        date: date,
      );
    }
  }

  void _paintStartAndEndDateSelections(Canvas canvas) {
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

    _paintStartAndEndDateSelections(context.canvas);

    if (showPreviousMonthDays) {
      _paintDays(
        context.canvas,
        _previousMonthVisibleDays,
        textStyle: previousMonthDayNumberTextStyle,
      );
    }

    _paintDays(
      context.canvas,
      _currentMonthDays,
    );

    if (showNextMonthDays) {
      _paintDays(
        context.canvas,
        _nextMonthVisibleDays,
        textStyle: nextMonthDayNumberTextStyle,
      );
    }
  }
}
