library src.extensions.date_time;

extension DateTimeExt on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);
}
