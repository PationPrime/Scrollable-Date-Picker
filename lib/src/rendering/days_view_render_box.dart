part of 'days_view_leaf_render_object_widget.dart';

class DaysViewRenderBox extends RenderBox {
  final _dateTimeNow = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

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

  TextStyle? _weekdayTextStyle;
  TextStyle? get weekdayTextStyle => _weekdayTextStyle;

  set weekdayTextStyle(TextStyle? style) {
    if (_weekdayTextStyle == style) return;
    _weekdayTextStyle = style;
    markNeedsPaint();
  }

  TextStyle? _dayNumberTextStyle;
  TextStyle? get dayNumberTextStyle => _dayNumberTextStyle ?? const TextStyle();

  set dayNumberTextStyle(TextStyle? style) {
    if (_dayNumberTextStyle == style) return;
    _dayNumberTextStyle = style;
    markNeedsPaint();
  }

  Color? _selectionColor;
  Color? get selectionColor => _selectionColor;

  set selectionColor(Color? color) {
    if (_selectionColor == color) return;
    _selectionColor = color;
    markNeedsPaint();
  }

  late SelectionDecorationModel _startDateSelectionDecoration;
  SelectionDecorationModel get startDateSelectionDecoration =>
      _startDateSelectionDecoration;

  set startDateSelectionDecoration(SelectionDecorationModel decoration) {
    if (_startDateSelectionDecoration == decoration) return;
    _startDateSelectionDecoration = decoration;
    markNeedsPaint();
  }

  late SelectionDecorationModel _endDateSelectionDecoration;
  SelectionDecorationModel get endDateSelectionDecoration =>
      _endDateSelectionDecoration;

  set endDateSelectionDecoration(SelectionDecorationModel decoration) {
    if (_endDateSelectionDecoration == decoration) return;
    _endDateSelectionDecoration = decoration;
    markNeedsPaint();
  }

  late TextStyle _currentDateTextStyle;
  TextStyle get currentDateTextStyle => _currentDateTextStyle;

  set currentDateTextStyle(TextStyle style) {
    if (_currentDateTextStyle == style) return;
    _currentDateTextStyle = style;
    markNeedsPaint();
  }

  late TextStyle _futureDatesTextStyle;
  TextStyle get futureDatesTextStyle => _futureDatesTextStyle;

  set futureDatesTextStyle(TextStyle style) {
    if (_futureDatesTextStyle == style) return;
    _futureDatesTextStyle = style;
    markNeedsPaint();
  }

  late TextStyle _weekendDaysTextStyle;
  TextStyle get weekendDaysTextStyle => _weekendDaysTextStyle;

  set weekendDaysTextStyle(TextStyle style) {
    if (_weekendDaysTextStyle == style) return;
    _weekendDaysTextStyle = style;
    markNeedsPaint();
  }

  late TextStyle _weekendDaysNameTextStyle;
  TextStyle get weekendDaysNameTextStyle => _weekendDaysNameTextStyle;

  set weekendDaysNameTextStyle(TextStyle style) {
    if (_weekendDaysNameTextStyle == style) return;
    _weekendDaysNameTextStyle = style;
    markNeedsPaint();
  }

  TextStyle? _previousMonthDayNumberTextStyle;
  TextStyle? get previousMonthDayNumberTextStyle =>
      _previousMonthDayNumberTextStyle;

  set previousMonthDayNumberTextStyle(TextStyle? style) {
    if (_previousMonthDayNumberTextStyle == style) return;
    _previousMonthDayNumberTextStyle = style;
    markNeedsPaint();
  }

  TextStyle? _nextMonthDayNumberTextStyle;
  TextStyle? get nextMonthDayNumberTextStyle => _nextMonthDayNumberTextStyle;

  set nextMonthDayNumberTextStyle(TextStyle? style) {
    if (_nextMonthDayNumberTextStyle == style) return;
    _nextMonthDayNumberTextStyle = style;
    markNeedsPaint();
  }

  late List<DayViewModel> _days;

  void _generateDays() {
    _days = [
      for (int i = 1; i <= daysCount; i++) DayViewModel(number: i),
    ];
  }

  late TapGestureRecognizer onTap;
  late VerticalDragGestureRecognizer onDrag;

  void _initOnTapUp() => onTap = TapGestureRecognizer()
    ..onTapDown = (
      TapDownDetails tapDownDetails,
    ) =>
        _onTapDown(tapDownDetails);

  void _initDragStart() => onDrag = VerticalDragGestureRecognizer()
    ..onStart = (
      DragStartDetails dragStartDetails,
    ) {};

  DayViewModel? _findTappedDay(TapDownDetails tapDownDetails) {
    DayViewModel? tappedDay;

    try {
      tappedDay = _days.firstWhere(
        (day) => day.rect?.contains(tapDownDetails.localPosition) ?? false,
      );
    } catch (e) {
      tappedDay = null;
    }

    return tappedDay;
  }

  void _onTapDown(TapDownDetails tapDownDetails) {
    final tappedDay = _findTappedDay(tapDownDetails);

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
  }

  List<DateTime>? _selectedDates;
  List<DateTime>? get selectedDates => _selectedDates;

  set selectedDates(List<DateTime>? dates) {
    _selectedDates = dates;
    markNeedsPaint();
  }

  DateRangeModel? _dateRange;
  DateRangeModel? get dateRange => _dateRange;

  set dateRange(DateRangeModel? range) {
    if (_dateRange == range) return;
    _dateRange = range;
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
    TextStyle? weekdayTextStyle,
    TextStyle? dayNumberTextStyle,
    required TextStyle weekendDaysTextStyle,
    required TextStyle weekendDaysNameTextStyle,
    required TextStyle currentDateTextStyle,
    required TextStyle futureDatesTextStyle,
    TextStyle? previousMonthDayNumberTextStyle,
    TextStyle? nextMonthDayNumberTextStyle,
    Color? selectionColor,
    required SelectionDecorationModel startDateSelectionDecoration,
    required SelectionDecorationModel endDateSelectionDecoration,
    String? localeName,
    required DateSelectionType dateSelectionType,
    DateTime? selectedSingleDate,
    List<DateTime>? selectedDates,
    DateRangeModel? dateRange,
    void Function(DateTime?)? onDateSelect,
    required bool showPreviousMonthDays,
    required bool showNextMonthDays,
    required bool futureDatesAreAvailable,
  })  : _startWeekday = startWeekday,
        _daysCount = daysCount,
        _viewDate = viewDate,
        _betweenDates = betweenDates,
        _showWeekdays = showWeekdays,
        _weekdayTextStyle = weekdayTextStyle,
        _selectionColor = selectionColor,
        _startDateSelectionDecoration = startDateSelectionDecoration,
        _endDateSelectionDecoration = endDateSelectionDecoration,
        _dayNumberTextStyle = dayNumberTextStyle,
        _weekendDaysTextStyle = weekendDaysTextStyle,
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
        _futureDatesAreAvailable = futureDatesAreAvailable {
    _generateDays();
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
      onTap.addPointer(event);
    }

    if (event is PointerMoveEvent) {
      // onDrag.addPointer(event);
    }
  }

  static const _minDesiredWidth = 100.0;

  int get rowsCount =>
      ((daysCount + startWeekday - 1) / 7).ceil() + (showWeekdays ? 1 : 0);

  double get _desiredHeight => rowsCount * 40;

  TextPainter _dayNumberPainer(
    int number, {
    TextStyle? textStyle,
  }) =>
      TextPainter(
        text: TextSpan(
          text: "$number",
          style: textStyle ?? dayNumberTextStyle,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredSize = Size(desiredWidth, _desiredHeight);

    return constraints.constrain(desiredSize);
  }

  void _layoutDays() {
    final dayStepDX = size.width / 7;
    final dayStepDY = _desiredHeight / rowsCount;

    final initialDX = (startWeekday - 1) * dayStepDX + dayStepDX / 2;
    final initialDY = dayStepDY / 2 + (showWeekdays ? dayStepDY : 0);

    Offset position = Offset(
      initialDX,
      initialDY,
    );

    for (final day in _days) {
      final nextDayWeekday = viewDate.copyWith(day: day.number + 1).weekday;

      final painter = _dayNumberPainer(day.number);

      painter.layout();

      final dayCenter = Offset(
        position.dx - painter.size.width / 2,
        position.dy - painter.size.height / 2,
      );

      _days.remove(day);

      _days.insert(
        day.number - 1,
        day.copyWith(
          selectionCenter: position,
          dayCenter: dayCenter,
          rect: Rect.fromCenter(
            center: position,
            width: dayStepDX,
            height: dayStepDY,
          ),
          date: viewDate.copyWith(
            day: day.number,
          ),
        ),
      );

      final dx = nextDayWeekday == 1 ? dayStepDX / 2 : position.dx + dayStepDX;
      final dy = nextDayWeekday == 1 ? position.dy + dayStepDY : position.dy;

      position = Offset(dx, dy);
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
    _layoutDays();
  }

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;
  @override
  double computeMinIntrinsicHeight(double width) => _desiredHeight;
  @override
  double computeMaxIntrinsicHeight(double width) => _desiredHeight;

  void _paintWeekdays(Canvas canvas) {
    if (!showWeekdays) {
      return;
    }

    final dayStepDX = size.width / 7;
    final dayStepDY = _desiredHeight / rowsCount;

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

      final dayCenter = Offset(
        position.dx - painter.size.width / 2,
        position.dy - painter.size.height / 2,
      );

      painter.paint(
        canvas,
        dayCenter,
      );

      final dx = position.dx + dayStepDX;

      position = Offset(dx, position.dy);
    }
  }

  void _paintDays(Canvas canvas) {
    for (final day in _days) {
      final painter = _dayNumberPainer(
        day.number,
        textStyle: day.date == _dateTimeNow
            ? currentDateTextStyle
            : day.date?.weekday == 6 || day.date?.weekday == 7
                ? weekendDaysTextStyle
                : !futureDatesAreAvailable && day.date!.isAfter(_dateTimeNow)
                    ? futureDatesTextStyle
                    : null,
      );

      painter.layout();

      painter.paint(
        canvas,
        day.dayCenter!,
      );
    }
  }

  void _drawSingleRectSelection(
    Canvas canvas,
    DayViewModel day, {
    SelectionDecorationModel? decoration,
  }) {
    Rect? rect = day.rect;

    if (rect is! Rect) {
      return;
    }

    if (decoration?.height is double) {
      rect = Rect.fromCenter(
        center: Offset(
          day.selectionCenter!.dx,
          day.selectionCenter!.dy,
        ),
        width: size.width / 7,
        height: decoration!.height!.clamp(
          0,
          _desiredHeight / rowsCount,
        ),
      );
    }

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: decoration?.topLeftCorner ?? Radius.zero,
        topRight: decoration?.topRightCorner ?? Radius.zero,
        bottomLeft: decoration?.bottomLeftCorner ?? Radius.zero,
        bottomRight: decoration?.bottomRightCorner ?? Radius.zero,
      ),
      Paint()..color = decoration?.color ?? startDateSelectionDecoration.color,
    );
  }

  void _drawSingleCircleSelection(
    Canvas canvas,
    Offset center, {
    SelectionDecorationModel? decoration,
  }) =>
      canvas.drawCircle(
        center,
        decoration?.width ??
            startDateSelectionDecoration.width ??
            size.width / 14,
        Paint()
          ..color = decoration?.color ?? startDateSelectionDecoration.color,
      );

  void _paintSingleRectSelection(
    Canvas canvas, {
    DateTime? date,
    SelectionDecorationModel? decoration,
  }) {
    DayViewModel? dayModel;

    if (date is! DateTime) {
      date = _selectedSingleDate;
    }

    try {
      dayModel = _days.firstWhere((day) => day.date == date);
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
    SelectionDecorationModel? decoration,
  }) {
    Offset? center;

    if (date is! DateTime) {
      date = _selectedSingleDate;
    }

    try {
      center = _days.firstWhere((day) => day.date == date).selectionCenter;
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
    SelectionDecorationModel? decoration,
  }) {
    switch (startDateSelectionDecoration.shape) {
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
    if (dateRange?.startDate is! DateTime) {
      return;
    }

    _paintSingleSelection(
      canvas,
      date: dateRange?.startDate,
      decoration: startDateSelectionDecoration,
    );

    if (dateRange?.endDate is! DateTime) {
      return;
    }

    _paintSingleSelection(
      canvas,
      date: dateRange?.endDate,
      decoration: endDateSelectionDecoration,
    );

    _paintSelectionBetweenDateRange(canvas);
  }

  void _paintSelectionBetweenDateRange(Canvas canvas) {
    final daysInRange = _days.where((day) =>
        day.date!.isAfter(dateRange!.startDate!) &&
        day.date!.isBefore(dateRange!.endDate!));

    for (final day in daysInRange) {
      _drawSingleRectSelection(
        canvas,
        day,
        decoration: SelectionDecorationModel(
          color: selectionColor ?? startDateSelectionDecoration.color,
          height: 30,
          topLeftCorner: day.date!.weekday == 1 || day == daysInRange.first
              ? const Radius.circular(12)
              : Radius.zero,
          bottomLeftCorner: day.date!.weekday == 1 || day == daysInRange.first
              ? const Radius.circular(12)
              : Radius.zero,
          topRightCorner: day.date!.weekday == 7 || day == daysInRange.last
              ? const Radius.circular(12)
              : Radius.zero,
          bottomRightCorner: day.date!.weekday == 7 || day == daysInRange.last
              ? const Radius.circular(12)
              : Radius.zero,
        ),
      );
    }
  }

  void _paintSelectedDates(Canvas canvas) {
    if (selectedDates is! List<DateTime>) return;

    for (final date in selectedDates!) {
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
      case DateSelectionType.multiDates:
        _paintSelectedDates(canvas);
      case DateSelectionType.dateRange:
        _paintRangeSelection(canvas);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _paintWeekdays(context.canvas);
    _paintStartAndEndDateSelections(context.canvas);
    _paintDays(context.canvas);
  }
}
