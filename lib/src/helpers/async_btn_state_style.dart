import 'package:flutter/material.dart';
import 'constants.dart';

/// Binds [ButtonStyle] and a [Widget]. Typically used in custom buttons.
///
/// NOTE that for argument [style], the follwing [ButtonStyle]'s arguments won't have any
/// effect:-
/// [ButtonStyle.fixedSize]
/// [ButtonStyle.textStyle]
/// [ButtonStyle.visualDensity]
///
///
class AsyncBtnStateStyle {
  /// Defines the [ButtonStyle] to use when the [AsyncBtnState] corresponds to this style
  ///
  /// Can be null
  final ButtonStyle? style;

  /// Defines the [Widget] to use when the [AsyncBtnState] corresponds to this style
  ///
  /// Can be null
  final Widget? widget;

  /// Creates an [AsyncBtnStateStyle]
  const AsyncBtnStateStyle({
    this.style,
    this.widget,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AsyncBtnStateStyle && other.style == style;
  }

  @override
  int get hashCode => style.hashCode ^ widget.hashCode;
}
