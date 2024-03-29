import 'package:flutter/material.dart';

import 'core/async_btn_core_abstract.dart';
import 'core/async_btn_states_controller.dart';
import 'helpers/async_btn_state_style.dart';

/// Implements [OutlinedButton] for asynchronous [onPressed]
class AsyncOutlinedBtn extends AsyncBtnCore {
  /// Creates an [AsyncOutlinedBtn]
  const AsyncOutlinedBtn({
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
    super.onLongPress,
    super.materialStatesController,
    super.styleBuilder,
    super.asyncBtnStatesController,
  });

  /// Same as [AsyncOutlinedButton()] but with sample values for [loadingStyle],
  /// [successStyle] and [failureStyle].
  factory AsyncOutlinedBtn.withDefaultStyles({
    Key? key,
    required Future<void> Function()? onPressed,
    required Widget child,
    Future<void> Function()? onLongPress,
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
        layoutBuilder = AsyncBtnCore.defaultLayoutBuilder,
    Widget Function(Widget child, Animation<double> animation)
        transitionBuilder = AsyncBtnCore.defaultTransitionBuilder,
    MaterialStatesController? materialStatesController,
    AsyncBtnStatesController? asyncBtnStatesController,
  }) {
    return AsyncOutlinedBtn(
      onPressed: onPressed,
      failureStyle: AsyncBtnStateStyle(
        style: OutlinedButton.styleFrom(
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
      loadingStyle: AsyncBtnStateStyle(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.amber,
        ),
        widget: const SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      ),
      successStyle: AsyncBtnStateStyle(
        style: OutlinedButton.styleFrom(
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
      onLongPress: onLongPress,
      materialStatesController: materialStatesController,
      asyncBtnStatesController: asyncBtnStatesController,
      child: child,
    );
  }

  @override
  State<AsyncBtnCore> createState() => _AsyncOutlinedButtonState();
}

class _AsyncOutlinedButtonState extends AsyncBtnCoreState {
  static const _simpleButton = OutlinedButton(
    onPressed: null,
    child: SizedBox(),
  );

  @override
  ButtonStyle intializeButtonStyle() {
    return (widget.style ?? const ButtonStyle())
        .merge(_simpleButton.themeStyleOf(context))
        .merge(_simpleButton.defaultStyleOf(context));
  }

  @override
  ButtonStyleButton makeButton(Widget child) {
    return OutlinedButton(
      onPressed: onPressed(),
      style: makeButtonStyle(),
      onLongPress: onLongPressed(),
      statesController: statesController,
      child: child,
    );
  }
}
