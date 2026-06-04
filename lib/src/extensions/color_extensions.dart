import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color applyOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255 * opacity).round());
  }
}
