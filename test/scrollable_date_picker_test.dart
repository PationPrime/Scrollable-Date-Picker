import 'package:flutter_test/flutter_test.dart';
import 'package:scrollable_date_picker/scrollable_date_picker.dart';

void main() {
  group(
    "assert tests",
    () {
      test(
        'Single date picker type',
        () {
          final scrollableDatePicker = ScrollableDatePicker(
            minDate: DateTime(2023),
            maxDate: DateTime(2024),
          );
          expect(
            scrollableDatePicker.dateSelectionType.isSingleDate &&
                scrollableDatePicker.dateRange is! DateRangeModel &&
                scrollableDatePicker.selectedDates is! List<DateTime>,
            true,
          );
        },
      );

      test(
        'Multiple dates picker type',
        () {
          final scrollableDatePicker = ScrollableDatePicker(
            minDate: DateTime(2023),
            maxDate: DateTime(2024),
            dateSelectionType: DateSelectionType.multipleDates,
          );

          expect(
            scrollableDatePicker.dateSelectionType.isMultiDates &&
                scrollableDatePicker.selectedSingleDate is! DateTime &&
                scrollableDatePicker.dateRange is! DateRangeModel,
            true,
          );
        },
      );

      test(
        'Date range picker type',
        () {
          final scrollableDatePicker = ScrollableDatePicker(
            minDate: DateTime(2023),
            maxDate: DateTime(2024),
            dateSelectionType: DateSelectionType.dateRange,
          );

          expect(
            scrollableDatePicker.dateSelectionType.isDateRange &&
                scrollableDatePicker.selectedSingleDate is! DateTime &&
                scrollableDatePicker.selectedDates is! List<DateTime>,
            true,
          );
        },
      );
    },
  );
}
