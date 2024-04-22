import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor: Colors.brown,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ScrollableDatePicker(
                minDate: DateTime(2022, 2, 1),
                maxDate: DateTime(2024),
                onDateSelect: (singleDate, dates, dateRange) {},
                dateSelectionType: DateSelectionType.dateRange,
                daysRowHeight: 45,
                singleSelectionDecoration: const SingleSelectionDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
                rangeSelectionDecoration: RangeSelectionDecoration(
                  color: const Color(0xFF3FB8AF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  height: 30,
                  startDateSelectionDecoration: const SingleSelectionDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3FB8AF),
                  ),
                  endDateSelectionDecoration: const SingleSelectionDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3FB8AF),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
