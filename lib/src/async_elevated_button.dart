import 'package:flutter/material.dart';

import 'core/async_button_core_abstract.dart';
import 'core/async_button_state_controller_abstract.dart';
import 'helpers/async_button_state_style.dart';

/// Implements [ElevatedButton] for asynchronous [onPressed]
@Deprecated(
  'Use AsyncElevatedBtn instead. '
  'This feature was deprecated after v1.0.1-beta.2',
)
class AsyncElevatedButton extends AsyncButtonCore {
  /// Creates an [AsyncElevatedButton]
  const AsyncElevatedButton({
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

  /// Same as [AsyncElevatedButton()] but with sample values for [loadingStyle],
  /// [successStyle] and [failureStyle].
  factory AsyncElevatedButton.withDefaultStyles({
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
    return AsyncElevatedButton(
      onPressed: onPressed,
      failureStyle: AsyncButtonStateStyle(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
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
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
        ),
        widget: const SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      successStyle: AsyncButtonStateStyle(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
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
  State<AsyncButtonCore> createState() => _AsyncElevatedButtonState();
}

class _AsyncElevatedButtonState extends AsyncButtonCoreState {
  static const _simpleButton = ElevatedButton(
    onPressed: null,
    child: null,
  );

  @override
  ButtonStyle intializeButtonStyle() {
    return (widget.style ?? const ButtonStyle())
        .merge(_simpleButton.defaultStyleOf(context));
  }

  @override
  ButtonStyleButton makeButton(Widget child) {
    return ElevatedButton(
      onPressed: onPressed(),
      // onPressed: null,
      style: makeButtonStyle(),
      // child: Text('execture'),
      child: child,
    );
  }
}
