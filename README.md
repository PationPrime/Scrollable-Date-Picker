# Scrollable Date Picker

Scrollable Date Picker allows to use single, multiple and range picker.

This package depends on [super_sliver_list](https://pub.dev/packages/super_sliver_list) package, primarily to use the "scroll to item" (scroll to initial date) functionality and [intl](https://pub.dev/packages/intl) package, primarily to use date formatting functionality.

## Getting Started

### Instructions

1. Open a command line and cd to your projects root folder
2. In your pubspec, add a package entry to your dependencies (example below)

### Pubspec

```yaml
dependencies:
  scrollable_date_picker: ^1.0.0
```

```dart
import 'package:scrollable_date_picker/scrollable_date_picker.dart';
```

3. Load the appropriate data by calling initializeDateFormatting() method.

```dart
Future<void> main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}
```

### Usage

Simple usage example

```dart
ScrollableDatePicker(
  minDate: DateTime(DateTime.now().year - 2),
  maxDate: DateTime.now().copyWith(month: 12),
  onDateSelect: (singleDate, dates, dateRange,) {},
),
```


