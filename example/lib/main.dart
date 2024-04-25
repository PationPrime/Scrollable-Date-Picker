import 'dart:async';

import 'package:example/action_button.dart';
import 'package:example/scrollable_date_picker_screen.dart';
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
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Scrollable Date Picker',
        home: Builder(
            builder: (context) => Scaffold(
                  backgroundColor: Colors.blueGrey,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          title: "Single date picker",
                          color: Colors.purpleAccent,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ScrollableDatePickerScreen(
                                selectionType: DateSelectionType.singleDate,
                              ),
                            ),
                          ),
                        ),
                        ActionButton(
                          title: "Multiple dates picker",
                          color: Colors.blueAccent,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ScrollableDatePickerScreen(
                                selectionType: DateSelectionType.multipleDates,
                              ),
                            ),
                          ),
                        ),
                        ActionButton(
                          title: "Date range picker",
                          color: Colors.tealAccent,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ScrollableDatePickerScreen(
                                selectionType: DateSelectionType.dateRange,
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
