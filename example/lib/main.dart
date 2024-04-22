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
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: ScrollableDatePicker(
                minDate: DateTime(2022, 2, 1),
                maxDate: DateTime(2024),
                onDateSelect: (singleDate, dates, dateRange) {},
                dateSelectionType: DateSelectionType.dateRange,
                rangeSelectionDecoration: RangeSelectionDecoration(
                  color: Colors.red,
                  startDateSelectionDecoration: SingleSelectionDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    // borderRadius: BorderRadius.circular(12),
                    // shape: BoxShape.circle,
                    // height: 20,
                    // width: 20,
                    color: Colors.cyan.withOpacity(0.2),
                  ),
                  endDateSelectionDecoration: SingleSelectionDecoration(
                    // shape: BoxShape.circle,
                    // height: 20,
                    // width: 20,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
