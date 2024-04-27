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

                  /// todo: convert to set and back to list
                  selectedDates: [
                    DateTime.now(),
                    DateTime.now().copyWith(day: 27).dateOnly,
                    DateTime.now().copyWith(day: 7),
                  ],
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
                        child: ActionButton(
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
                        child: ActionButton(
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
