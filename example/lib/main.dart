import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';

Future<void> main() async {
  /// This should be called for at least one [locale] before any date
  /// formatting methods are called. It sets up the lookup for date
  /// symbols. Both the [locale] and [ignored] parameter are ignored, as
  /// the data for all locales is directly available.
  await initializeDateFormatting();

  runApp(const ScrollableDatePickerApp());
}

class ScrollableDatePickerApp extends StatefulWidget {
  const ScrollableDatePickerApp({super.key});

  @override
  State<ScrollableDatePickerApp> createState() =>
      _ScrollableDatePickerAppState();
}

class _ScrollableDatePickerAppState extends State<ScrollableDatePickerApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Scrollable Date Picker',
        home: Builder(
            builder: (context) => Scaffold(
                  backgroundColor: Colors.grey[800],
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          child: _ActionButton(
                            title: "Single date picker",
                            color: Colors.red,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const _ScrollableDatePickerScreen(
                                  selectionType: DateSelectionType.singleDate,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: SizedBox(
                            width: 250,
                            child: _ActionButton(
                              title: "Multiple dates picker",
                              color: Colors.green,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const _ScrollableDatePickerScreen(
                                    selectionType:
                                        DateSelectionType.multipleDates,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: _ActionButton(
                            title: "Date range picker",
                            color: Colors.blue,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const _ScrollableDatePickerScreen(
                                  selectionType: DateSelectionType.dateRange,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      );
}

class _ScrollableDatePickerScreen extends StatefulWidget {
  final DateSelectionType selectionType;

  const _ScrollableDatePickerScreen({
    required this.selectionType,
  });

  @override
  State<_ScrollableDatePickerScreen> createState() =>
      _ScrollableDatePickerScreenState();
}

class _ScrollableDatePickerScreenState
    extends State<_ScrollableDatePickerScreen> {
  DateTime? _selectedSingleDate;
  List<DateTime>? _selectedDates;
  DateRangeModel? _dateRange;

  String get _selectedDatesText => _selectedDates is List<DateTime>
      ? "$_selectedDates"
      : _selectedSingleDate is DateTime
          ? "$_selectedSingleDate"
          : "${_dateRange?.startDate} - ${_dateRange?.endDate}";

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[800],
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                child: ScrollableDatePicker(
                  datePickerPadding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                  minDate: DateTime(DateTime.now().year - 2),
                  maxDate: DateTime.now().copyWith(month: 12),
                  onDateSelect: (
                    singleDate,
                    dates,
                    dateRange,
                  ) {
                    setState(
                      () {
                        _selectedSingleDate = singleDate;
                        _selectedDates = dates;
                        _dateRange = dateRange;
                      },
                    );
                  },
                  dateSelectionType: widget.selectionType,
                  selectedDates:_selectedDates,
                  futureDatesAreAvailable: false,
                  initialDate: DateTime.now(),
                ),
              ),
              if (_selectedSingleDate is DateTime ||
                  _dateRange is DateRangeModel ||
                  _selectedDates is List<DateTime>)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _ActionButton(
                          color: Colors.red,
                          title: "Clear",
                          onTap: () => setState(
                            () {
                              _selectedSingleDate = null;
                              _selectedDates = null;
                              _dateRange = null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _ActionButton(
                          color: Colors.green,
                          title: "Select",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Column(
                                  children: [
                                    const Text(
                                      "Selected dates:",
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      _selectedDatesText,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      );
}

class _ActionButton extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.title,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
        highlightElevation: 0,
        elevation: 0,
        color: color,
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
