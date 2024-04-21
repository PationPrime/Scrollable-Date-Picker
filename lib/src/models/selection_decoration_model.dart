library src.models.selection_decoration;

import 'package:flutter/material.dart';

@immutable
class SelectionDecorationModel {
  final BoxShape shape;
  final Radius topLeftCorner;
  final Radius topRightCorner;
  final Radius bottomLeftCorner;
  final Radius bottomRightCorner;
  final Color color;
  final double? height;
  final double? width;

  const SelectionDecorationModel({
    this.shape = BoxShape.rectangle,
    this.topLeftCorner = Radius.zero,
    this.topRightCorner = Radius.zero,
    this.bottomLeftCorner = Radius.zero,
    this.bottomRightCorner = Radius.zero,
    this.color = Colors.black,
    this.height,
    this.width,
  });

  SelectionDecorationModel copyWith({
    BoxShape? shape,
    Radius? topLeftCorner,
    Radius? topRightCorner,
    Radius? bottomLeftCorner,
    Radius? bottomRightCorner,
    Color? color,
    double? height,
    double? width,
  }) =>
      SelectionDecorationModel(
        shape: shape ?? this.shape,
        topLeftCorner: topLeftCorner ?? this.topLeftCorner,
        topRightCorner: topRightCorner ?? this.topRightCorner,
        bottomLeftCorner: bottomLeftCorner ?? this.bottomLeftCorner,
        bottomRightCorner: bottomRightCorner ?? this.bottomRightCorner,
        color: color ?? this.color,
        height: height ?? this.height,
        width: width ?? this.width,
      );

  @override
  int get hashCode => Object.hash(
        shape,
        topLeftCorner,
        topRightCorner,
        bottomLeftCorner,
        bottomRightCorner,
        color,
        height,
        width,
      );

  @override
  bool operator ==(Object other) =>
      other is SelectionDecorationModel &&
      other.runtimeType == runtimeType &&
      other.shape == shape &&
      other.topLeftCorner == topLeftCorner &&
      other.topRightCorner == topRightCorner &&
      other.bottomLeftCorner == bottomLeftCorner &&
      other.bottomRightCorner == bottomRightCorner &&
      other.color == color &&
      other.height == height &&
      other.width == width;
}
