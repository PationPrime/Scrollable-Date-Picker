part of 'selection_decoration.dart';

final class SingleSelectionDecoration extends SelectionDecoration {
  final BoxShape shape;
  final double? width;

  const SingleSelectionDecoration({
    this.shape = BoxShape.rectangle,
    super.borderRadius,
    super.color,
    super.height,
    super.selectedDateTextStyle,
    this.width,
  });

  @override
  SingleSelectionDecoration copyWith({
    BoxShape? shape,
    BorderRadius? borderRadius,
    Color? color,
    double? height,
    TextStyle? selectedDateTextStyle,
    double? width,
  }) =>
      SingleSelectionDecoration(
        shape: shape ?? this.shape,
        borderRadius: borderRadius ?? this.borderRadius,
        color: color ?? this.color,
        height: height ?? this.height,
        selectedDateTextStyle:
            selectedDateTextStyle ?? this.selectedDateTextStyle,
        width: width ?? this.width,
      );

  @override
  int get hashCode => Object.hash(
        shape,
        borderRadius,
        color,
        height,
        selectedDateTextStyle,
        width,
      );

  @override
  bool operator ==(Object other) =>
      other is SingleSelectionDecoration &&
      other.runtimeType == runtimeType &&
      other.shape == shape &&
      other.borderRadius == borderRadius &&
      other.color == color &&
      other.height == height &&
      other.selectedDateTextStyle == selectedDateTextStyle &&
      other.width == width;
}
