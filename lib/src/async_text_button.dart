import 'package:flutter/material.dart';

import 'core/async_button_core_abstract.dart';
import 'core/async_button_state_controller_abstract.dart';
import 'helpers/async_button_state_style.dart';

/// Implements [TextButton] for asynchronous [onPressed]
class AsyncTextButton extends AsyncButtonCore {
  /// Creates an [AsyncTextButton]
  const AsyncTextButton({
    super.key,
    super.loadingStyle,
    super.loadingStyleBuilder,
    super.successStyle,
    super.successStyleBuilder,
    super.failureStyle,
    super.failureStyleBuilder,
    super.style,
    required super.onPressed,
    required super.child,
    super.switchBackAfterCompletion,
    super.switchBackDelay,
    super.lockWhileAlreadyExecuting,
    super.sizeAnimationCurve,
    super.sizeAnimationClipper,
    super.sizeAnimationDuration,
    super.switchInAnimationCurve,
    super.switchInAnimationDuration,
    super.switchOutAnimationCurve,
    super.switchOutAnimationDuration,
    super.layoutBuilder,
    super.transitionBuilder,
  });

  /// Same as [AsyncOutlinedButton()] but with sample values for [loadingStyle],
  /// [successStyle] and [failureStyle].
  factory AsyncTextButton.withDefaultStyles({
    Key? key,
    required Future<void> Function(
            AsyncButtonStateController btnStateController)?
        onPressed,
    required Widget child,
    bool switchBackAfterCompletion = true,
    Duration switchBackDelay = const Duration(seconds: 2),
    bool lockWhileAlreadyExecuting = true,
    Duration sizeAnimationDuration = const Duration(milliseconds: 100),
    Duration switchInAnimationDuration = const Duration(milliseconds: 300),
    Duration switchOutAnimationDuration = const Duration(milliseconds: 100),
    Clip sizeAnimationClipper = Clip.none,
    Curve sizeAnimationCurve = Curves.ease,
    Curve switchInAnimationCurve = Curves.ease,
    Curve switchOutAnimationCurve = Curves.ease,
    ButtonStyle? style,
    Widget Function(Widget? currentChild, List<Widget> previousChildren)
        layoutBuilder = AsyncButtonCore.defaultLayoutBuilder,
    Widget Function(Widget child, Animation<double> animation)
        transitionBuilder = AsyncButtonCore.defaultTransitionBuilder,
  }) {
    return AsyncTextButton(
      onPressed: onPressed,
      failureStyle: AsyncButtonStateStyle(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
        ),
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.error),
            SizedBox(width: 4),
            Text('Error!')
          ],
        ),
      ),
      loadingStyle: AsyncButtonStateStyle(
        style: TextButton.styleFrom(
          foregroundColor: Colors.amber,
        ),
        widget: const SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      ),
      successStyle: AsyncButtonStateStyle(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green,
        ),
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check),
            SizedBox(width: 4),
            Text('Success!')
          ],
        ),
      ),
      lockWhileAlreadyExecuting: lockWhileAlreadyExecuting,
      sizeAnimationDuration: sizeAnimationDuration,
      style: style,
      key: key,
      switchBackAfterCompletion: switchBackAfterCompletion,
      switchBackDelay: switchBackDelay,
      switchInAnimationDuration: switchInAnimationDuration,
      switchOutAnimationDuration: switchOutAnimationDuration,
      sizeAnimationClipper: sizeAnimationClipper,
      sizeAnimationCurve: sizeAnimationCurve,
      switchInAnimationCurve: switchInAnimationCurve,
      switchOutAnimationCurve: switchOutAnimationCurve,
      transitionBuilder: transitionBuilder,
      layoutBuilder: layoutBuilder,
      child: child,
    );
  }

  @override
  State<AsyncButtonCore> createState() => _AsyncTextButtonState();
}

class _AsyncTextButtonState extends AsyncButtonCoreState {
  static const _simpleButton = TextButton(
    onPressed: null,
    child: SizedBox(),
  );

  @override
  ButtonStyle intializeButtonStyle() {
    return (widget.style ?? const ButtonStyle())
        .merge(_simpleButton.defaultStyleOf(context));
  }

  @override
  ButtonStyleButton makeButton(Widget child) {
    return TextButton(
      onPressed: onPressed(),
      style: makeButtonStyle(),
      child: child,
    );
  }
}
