library src.models.selection_decoration;

import 'package:flutter/material.dart';

part 'range_selection_decoration.dart';
part 'single_selection_decoration.dart';

@immutable
abstract final class SelectionDecoration {
  final BorderRadius borderRadius;
  final double? height;
  final Color color;

  const SelectionDecoration({
    this.borderRadius = BorderRadius.zero,
    this.height,
    this.color = Colors.black,
  });

  SelectionDecoration copyWith();
}
