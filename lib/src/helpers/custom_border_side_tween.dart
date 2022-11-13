import 'package:flutter/widgets.dart';

/// A custom implementation for [Tween] between [BorderSide]s
class CustomBorderSideTween extends Tween<BorderSide?> {
  /// Creates a [BorderSide] tween.
  ///
  CustomBorderSideTween({super.begin, super.end});

  /// Returns the value this tween has at the given animation clock value.
  @override
  BorderSide? lerp(double t) {
    return BorderSide.lerp(begin ?? BorderSide.none, end ?? BorderSide.none, t);
  }
}
