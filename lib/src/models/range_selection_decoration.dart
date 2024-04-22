part of 'selection_decoration.dart';

final class RangeSelectionDecoration extends SelectionDecoration {
  final SingleSelectionDecoration startDateSelectionDecoration;
  final SingleSelectionDecoration endDateSelectionDecoration;

  const RangeSelectionDecoration({
    this.startDateSelectionDecoration = const SingleSelectionDecoration(),
    this.endDateSelectionDecoration = const SingleSelectionDecoration(),
    super.borderRadius,
    super.height,
    super.color,
    super.selectedDateTextStyle,
  });

  @override
  RangeSelectionDecoration copyWith({
    SingleSelectionDecoration? startDateSelectionDecoration,
    SingleSelectionDecoration? endDateSelectionDecoration,
    Color? color,
    BorderRadius? borderRadius,
    double? height,
    TextStyle? selectedDateTextStyle,
  }) =>
      RangeSelectionDecoration(
        startDateSelectionDecoration:
            startDateSelectionDecoration ?? this.startDateSelectionDecoration,
        endDateSelectionDecoration:
            endDateSelectionDecoration ?? this.endDateSelectionDecoration,
        color: color ?? this.color,
        borderRadius: borderRadius ?? this.borderRadius,
        height: height ?? this.height,
        selectedDateTextStyle:
            selectedDateTextStyle ?? this.selectedDateTextStyle,
      );

  @override
  int get hashCode => Object.hash(
        startDateSelectionDecoration,
        endDateSelectionDecoration,
        color,
        borderRadius,
        height,
        selectedDateTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      other is RangeSelectionDecoration &&
      other.runtimeType == runtimeType &&
      other.startDateSelectionDecoration == startDateSelectionDecoration &&
      other.endDateSelectionDecoration == endDateSelectionDecoration &&
      other.color == color &&
      other.borderRadius == borderRadius &&
      other.height == height &&
      other.selectedDateTextStyle == selectedDateTextStyle;
}
