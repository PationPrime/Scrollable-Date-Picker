library src.constants.view;

import 'dart:io';
import 'package:intl/intl.dart';

abstract base class ViewConstants {
  /// Method, which return list of weekday names
  static List<String> shortWeekdayNamesFromMonday({
    String? localeName,
    bool? startFromSunday,
  }) {
    final shortWeekdayNames = DateFormat.EEEE(localeName ?? Platform.localeName)
        .dateSymbols
        .SHORTWEEKDAYS;

    if (startFromSunday ?? false) {
      return shortWeekdayNames;
    }

    final weekdays = [...shortWeekdayNames];

    final sunday = weekdays.removeAt(0);

    return [
      ...weekdays,
      sunday,
    ];
  }
}
