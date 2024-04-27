import 'dart:async';

import 'package:example/action_button.dart';
import 'package:example/scrollable_date_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';

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
                  backgroundColor: Colors.grey[800],
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          child: ActionButton(
                            title: "Single date picker",
                            color: Colors.red,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ScrollableDatePickerScreen(
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
                            child: ActionButton(
                              title: "Multiple dates picker",
                              color: Colors.green,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ScrollableDatePickerScreen(
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
                          child: ActionButton(
                            title: "Date range picker",
                            color: Colors.blue,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ScrollableDatePickerScreen(
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
