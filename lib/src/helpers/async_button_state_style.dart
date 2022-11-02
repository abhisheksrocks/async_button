import 'package:flutter/material.dart';

/// The [style]'s [ButtonStyle.fixedSize], [ButtonStyle.textStyle] and [ButtonStyle.visualDensity]
/// arguments won't have any effect.
class AsyncButtonStateStyle {
  /// Defines the [ButtonStyle] to use when the [ButtonState] corresponds to this style
  ///
  /// Can be null
  final ButtonStyle? style;

  /// Defines the [Widget] to use when the [ButtonState] corresponds to this style
  ///
  /// Can be null
  final Widget? widget;

  /// Creates an [AsyncButtonStateStyle]
  AsyncButtonStateStyle({
    this.style,
    this.widget,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AsyncButtonStateStyle && other.style == style;
  }

  @override
  int get hashCode => style.hashCode ^ widget.hashCode;
}
