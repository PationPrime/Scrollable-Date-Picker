library src.extensions.box_shape;

import 'package:flutter/material.dart';

extension BoxShapeState on BoxShape {
  bool get isCicle => this == BoxShape.circle;
  bool get isRectangle => this == BoxShape.rectangle;
}
