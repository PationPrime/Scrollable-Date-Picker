part of 'selection_decoration.dart';

@immutable
final class RangeSelectionDecoration extends SelectionDecoration {
  final SingleSelectionDecoration startDateSelectionDecoration;
  final SingleSelectionDecoration endDateSelectionDecoration;

  const RangeSelectionDecoration({
    this.startDateSelectionDecoration = const SingleSelectionDecoration(),
    this.endDateSelectionDecoration = const SingleSelectionDecoration(),
    super.borderRadius,
    super.height,
    super.color,
  });

  @override
  RangeSelectionDecoration copyWith({
    SingleSelectionDecoration? startDateSelectionDecoration,
    SingleSelectionDecoration? endDateSelectionDecoration,
    Color? color,
    BorderRadius? borderRadius,
    double? height,
  }) =>
      RangeSelectionDecoration(
        startDateSelectionDecoration:
            startDateSelectionDecoration ?? this.startDateSelectionDecoration,
        endDateSelectionDecoration:
            endDateSelectionDecoration ?? this.endDateSelectionDecoration,
        color: color ?? this.color,
        borderRadius: borderRadius ?? this.borderRadius,
        height: height ?? this.height,
      );

  @override
  int get hashCode => Object.hash(
        startDateSelectionDecoration,
        endDateSelectionDecoration,
        color,
        borderRadius,
        height,
      );

  @override
  bool operator ==(Object other) =>
      other is RangeSelectionDecoration &&
      other.runtimeType == runtimeType &&
      other.startDateSelectionDecoration == startDateSelectionDecoration &&
      other.endDateSelectionDecoration == endDateSelectionDecoration &&
      other.color == color &&
      other.borderRadius == borderRadius &&
      other.height == height;
}
