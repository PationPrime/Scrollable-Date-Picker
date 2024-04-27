library src.typedefs;

import 'package:flutter/material.dart';

typedef HeaderBuilder = Widget Function(
  BuildContext,
  DateTime,
  Function(DateTime),
);
