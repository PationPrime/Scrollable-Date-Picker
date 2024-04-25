import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';

import 'action_button.dart';

class ScrollableDatePickerScreen extends StatefulWidget {
  final DateSelectionType selectionType;

  const ScrollableDatePickerScreen({
    super.key,
    required this.selectionType,
  });

  @override
  State<ScrollableDatePickerScreen> createState() =>
      _ScrollableDatePickerScreenState();
}

class _ScrollableDatePickerScreenState
    extends State<ScrollableDatePickerScreen> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: [
            SizedBox(
              child: ScrollableDatePicker(
                datePickerPadding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                minDate: DateTime(DateTime.now().year - 1, 2, 1),
                maxDate: DateTime.now(),
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
                selectedSingleDate: _selectedSingleDate,
                selectedDates: _selectedDates,
                dateRange: _dateRange,
                showNextMonthDays: true,
                showPreviousMonthDays: true,
              ),
            ),
            if (_selectedSingleDate is DateTime ||
                _dateRange is DateRangeModel ||
                _selectedDates is List<DateTime>)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      color: Colors.redAccent,
                      title: "Clear",
                      onTap: () => setState(
                        () {
                          _selectedSingleDate = null;
                          _selectedDates = null;
                          _dateRange = null;
                        },
                      ),
                    ),
                    ActionButton(
                      color: Colors.greenAccent,
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
                  ],
                ),
              )
          ],
        ),
      );
}
