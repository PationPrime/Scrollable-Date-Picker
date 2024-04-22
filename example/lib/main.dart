import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
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
  DateTime? selectedSingleDate;
  List<DateTime>? selectedDates;
  DateRangeModel? dateRange;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Scrollable Date Picker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ScrollableDatePicker(
                    minDate: DateTime(2022, 2, 1),
                    maxDate: DateTime(2024),
                    onDateSelect: (
                      singleDate,
                      dates,
                      dateRange,
                    ) {
                      setState(
                        () {
                          selectedSingleDate = singleDate;
                          selectedDates = dates;
                          this.dateRange = dateRange;
                        },
                      );
                    },
                    dateSelectionType: DateSelectionType.singleDate,
                    selectedSingleDate: selectedSingleDate,
                    selectedDates: selectedDates,
                    dateRange: dateRange,
                    dayNumberTextStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    singleSelectionDecoration: const SingleSelectionDecoration(
                      shape: BoxShape.circle,
                      selectedDateTextStyle: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    rangeSelectionDecoration: RangeSelectionDecoration(
                      color: const Color(0xFF3FB8AF).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      selectedDateTextStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      height: 30,
                      startDateSelectionDecoration:
                          const SingleSelectionDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF3FB8AF),
                        height: 20,
                      ),
                      endDateSelectionDecoration:
                          const SingleSelectionDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF3FB8AF),
                        height: 20,
                      ),
                    ),
                  ),
                ),
                if (selectedSingleDate is DateTime ||
                    dateRange is DateRangeModel ||
                    selectedDates is List<DateTime>)
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: MaterialButton(
                        highlightElevation: 0,
                        elevation: 0,
                        color: Colors.redAccent,
                        onPressed: () => setState(
                          () {
                            selectedSingleDate = null;
                            selectedDates = null;
                            dateRange = null;
                          },
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
}
