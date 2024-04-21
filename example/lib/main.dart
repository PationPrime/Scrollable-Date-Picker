import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor: Colors.brown,
          body: ScrollableDatePicker(
            minDate: DateTime(2022, 2, 1),
            maxDate: DateTime(2024),
            onDateSelect: (
              singleDate,
              dates,
              dateRange,
            ) {
              log("singleDate: $singleDate");
              log("dates: $dates");
              log(
                "dateRange startDate: ${dateRange?.startDate}, dateRange endDate: ${dateRange?.endDate}",
              );
            },
            dateSelectionType: DateSelectionType.singleDate,
          ),
        ),
      );
}
