import 'package:flutter/material.dart';

/// NOTE
///
/// For argument [style], the follwing [ButtonStyle]'s arguments won't have any
/// effect:-
/// [ButtonStyle.fixedSize]
/// [ButtonStyle.textStyle]
/// [ButtonStyle.visualDensity]
///
///
@Deprecated(
  'This feature was deprecated after v1.0.1-beta.2',
)
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
  const AsyncButtonStateStyle({
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
