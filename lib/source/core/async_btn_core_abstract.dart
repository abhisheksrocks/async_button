import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helpers/async_btn_state_style.dart';
import '../helpers/constants.dart';
import '../helpers/custom_border_side_tween.dart';
import 'async_btn_states_controller.dart';

/// Base abstract class for creating async button
abstract class AsyncBtnCore extends StatefulWidget {
  /// creates an [AsyncBtnCore]
  const AsyncBtnCore({
    Key? key,
    required this.child,
    this.asyncBtnStatesController,
    this.materialStatesController,
    this.loadingStyle,
    this.loadingStyleBuilder,
    this.successStyle,
    this.successStyleBuilder,
    this.failureStyle,
    this.failureStyleBuilder,
    this.style,
    this.styleBuilder,
    this.onPressed,
    this.onLongPress,
    this.switchBackAfterCompletion = true,
    this.switchBackDelay = const Duration(seconds: 2),
    this.lockWhileAlreadyExecuting = true,
    this.sizeAnimationCurve = Curves.ease,
    this.sizeAnimationClipper = Clip.none,
    this.sizeAnimationDuration = const Duration(milliseconds: 100),
    this.switchInAnimationCurve = Curves.ease,
    this.switchInAnimationDuration = const Duration(milliseconds: 300),
    this.switchOutAnimationCurve = Curves.ease,
    this.switchOutAnimationDuration = const Duration(milliseconds: 100),
    this.layoutBuilder = defaultLayoutBuilder,
    this.transitionBuilder = defaultTransitionBuilder,
  }) : super(key: key);

  /// The current child widget to display. If there was a previous child, then
  /// that child will be faded out using the [switchOutAnimationCurve], while the new
  /// child is faded in with the [switchInAnimationCurve], over the [switchInAnimationDuration].
  ///
  /// If there was no previous child, then this child will fade in using the
  /// [switchInAnimationCurve] over the [switchInAnimationDuration].
  ///
  /// The child is considered to be "new" if it has a different [Key]
  /// or when current [AsyncBtnState] has changed.
  ///
  /// To change the kind of transition used, see [transitionBuilder].
  final Widget child;

  /// Used to manipulate button's styles
  final AsyncBtnStatesController? asyncBtnStatesController;

  /// {@macro flutter.material.inkwell.statesController}
  final MaterialStatesController? materialStatesController;

  /// Defines the corresponding style for if button's current [AsyncBtnState] is
  /// [AsyncBtnState.loading]
  ///
  /// Can be null, in which case, uses the [style] and [child] instead.
  final AsyncBtnStateStyle? loadingStyle;

  /// Same as [loadingStyle] but the result is generated at runtime.
  ///
  /// If the result is not null, it takes precedence over [loadingStyle].
  final AsyncBtnStateStyle? Function(dynamic data)? loadingStyleBuilder;

  /// Defines the corresponding style for if button's current [AsyncBtnState] is
  /// [AsyncBtnState.success]
  ///
  /// Can be null, in which case, uses the [style] and [child] instead.
  final AsyncBtnStateStyle? successStyle;

  /// Same as [successStyle] but the result is generated at runtime.
  ///
  /// If the result is not null, it takes precedence over [successStyle].
  final AsyncBtnStateStyle? Function(dynamic data)? successStyleBuilder;

  /// Defines the corresponding style for if button's current [AsyncBtnState] is
  /// [AsyncBtnState.failure]
  ///
  /// Can be null, in which case, uses the [style] and [child] instead.
  final AsyncBtnStateStyle? failureStyle;

  /// Same as [failureStyle] but the result is generated at runtime.
  ///
  /// If the result is not null, it takes precedence over [failureStyle].
  final AsyncBtnStateStyle? Function(dynamic data)? failureStyleBuilder;

  /// Defines the default appearance of the button.
  ///
  /// Can be null, in which case, uses the [ButtonStyle] from current [Theme]
  final ButtonStyle? style;

  /// Works simlar to [style] with [child] but the result is generated at runtime.
  ///
  /// If the result is not null, it takes precedence over [style] and/or [child].
  final AsyncBtnStateStyle? Function(dynamic data)? styleBuilder;

  /// Executed when the button is pressed, can be null
  final Future<void> Function()? onPressed;

  /// Executed when the button is pressed and hold, can be null
  final Future<void> Function()? onLongPress;

  /// Whether to switch back to idle style(and widget)
  final bool switchBackAfterCompletion;

  /// Duration to wait before switching back to original idle state.
  ///
  /// Works only if [switchBackAfterCompletion] is true.
  final Duration switchBackDelay;

  /// Whether to execute [onPressed] if the function is already executing.
  final bool lockWhileAlreadyExecuting;

  /// The animation curve to use when transitioning in a new [child].
  ///
  /// This curve is applied to the given [child] when that property is set to a
  /// new child. Changing [switchInAnimationCurve] will not affect the curve of a
  /// transition already in progress.
  ///
  /// The [switchOutAnimationCurve] is used when fading out, except that if [child] is
  /// changed while the current child is in the middle of fading in,
  /// [switchInAnimationCurve] will be run in reverse from that point instead of jumping
  /// to the corresponding point on [switchOutAnimationCurve].
  final Curve switchInAnimationCurve;

  /// The duration of the transition from the old [child] value to the new one.
  ///
  /// This duration is applied to the given [child] when that property is set to
  /// a new child. The same duration is used when fading out, unless
  /// [switchOutAnimationDuration] is set. Changing [switchInAnimationDuration] will not affect the
  /// durations of transitions already in progress.
  final Duration switchInAnimationDuration;

  /// The animation curve to use when transitioning a previous [child] out.
  ///
  /// This curve is applied to the [child] when the child is faded in (or when
  /// the widget is created, for the first child). Changing [switchOutAnimationDuration]
  /// will not affect the curves of already-visible widgets, it only affects the
  /// curves of future children.
  ///
  /// If [child] is changed while the current child is in the middle of fading
  /// in, [switchInAnimationCurve] will be run in reverse from that point instead of
  /// jumping to the corresponding point on [switchOutAnimationDuration].
  final Curve switchOutAnimationCurve;

  /// The duration of the transition from the new [child] value to the old one.
  ///
  /// This duration is applied to the given [child] when that property is set to
  /// a new child. Changing [switchOutAnimationDuration] will not affect the durations of
  /// transitions already in progress.
  ///
  /// If not set, then the value of [switchInAnimationDuration] is used by default.
  final Duration switchOutAnimationDuration;

  /// The animation curve when transitioning this widget's size to match the
  /// child's size.
  final Curve sizeAnimationCurve;

  /// The duration when transitioning this widget's size to match the child's
  /// size.
  final Duration sizeAnimationDuration;

  /// Defaults to [Clip.none], and must not be null.
  final Clip sizeAnimationClipper;

  // A function that wraps all of the children that are transitioning out, and
  /// the [child] that's transitioning in, with a widget that lays all of them
  /// out. This is called every time this widget is built. The function must not
  /// return null.
  ///
  /// The default is [AsyncBtnCore.defaultLayoutBuilder].
  final Widget Function(Widget? currentChild, List<Widget> previousChildren)
      layoutBuilder;

  /// A function that wraps a new [child] with an animation that transitions
  /// the [child] in when the animation runs in the forward direction and out
  /// when the animation runs in the reverse direction. This is only called
  /// when a new [child] is set (not for each build), or when a new
  /// [transitionBuilder] is set. If a new [transitionBuilder] is set, then
  /// the transition is rebuilt for the current child and all previous children
  /// using the new [transitionBuilder]. The function must not return null.
  ///
  /// The default is [AsyncBtnCore.defaultTransitionBuilder].
  ///
  /// The animation provided to the builder has the [switchInAnimationDuration] and
  /// [switchInAnimationCurve] or [switchOutAnimationCurve] applied as provided when the
  /// corresponding [child] was first provided.
  final Widget Function(Widget child, Animation<double> animation)
      transitionBuilder;

  /// The transition builder used as the default value of [transitionBuilder].
  ///
  /// The new child is given a [FadeTransition] and [ScaleTransition] which increases
  /// size and opacity as the animation goes from 0.0 to 1.0, and decreases when
  /// the animation is reversed.
  static Widget defaultTransitionBuilder(
      Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  /// The layout builder used as the default value of [layoutBuilder].
  ///
  /// The new child is placed in a [Stack] that sizes itself to match the
  /// largest of the child or a previous child. The children are centered on
  /// each other.
  static Widget defaultLayoutBuilder(
      Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ...previousChildren,
        if (currentChild != null) currentChild,
      ],
    );
  }

  /// Whether the button is enabled or disabled.
  ///
  /// Buttons are disabled by default. To enable a button, set its [onPressed]
  /// or [onLongPress] properties to a non-null value.
  bool get enabled => onPressed != null || onLongPress != null;
}

/// Implements the [State] for [AsyncBtnCore]
abstract class AsyncBtnCoreState extends State<AsyncBtnCore>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _foregroundColorAnimation;
  late Animation<Color?> _overlayColorAnimation;
  late Animation<double?> _elevationAnimation;
  late Animation<Color?> _shadowColorAnimation;
  late Animation<ShapeBorder?> _shapeBorderAnimation;
  late Animation<Color?> _surfaceTintColorAnimation;
  // late Animation<TextStyle?> _textStyleAnimation;
  late Animation<EdgeInsetsGeometry?> _egdeInsetsGeometryAnimation;
  late Animation<AlignmentGeometry?> _alignmentGeometryAnimation;
  // late Animation<Size?> _fixedSizeAnimation;
  late Animation<Size?> _minimumSizeAnimation;
  late Animation<Size?> _maximumSizeAnimation;
  late Animation<BorderSide?> _borderSideAnimation;

  final ColorTween _backgroundColorTween = ColorTween();
  final ColorTween _foregroundColorTween = ColorTween();
  final ColorTween _overlayColorTween = ColorTween();
  final Tween<double> _elevationTween = Tween<double>();
  final ColorTween _shadowColorTween = ColorTween();
  final ShapeBorderTween _shapeBorderTween = ShapeBorderTween();
  final ColorTween _surfaceTintColorTween = ColorTween();
  // final TextStyleTween _textStyleTween = TextStyleTween();
  final EdgeInsetsGeometryTween _egdeInsetsGeometryTween =
      EdgeInsetsGeometryTween();
  final AlignmentGeometryTween _alignmentGeometryTween =
      AlignmentGeometryTween();
  // final SizeTween _fixedSizeTween = SizeTween();
  final SizeTween _minimumSizeTween = SizeTween();
  final SizeTween _maximumSizeTween = SizeTween();
  final CustomBorderSideTween _borderSideTween = CustomBorderSideTween();

  /// Keeps track of whether [AsyncBtnCore.onPressed] is currently executing
  bool isExecuting = false;

  /// Keeps track of current [AsyncBtnState]
  AsyncBtnState currentButtonState = AsyncBtnState.idle;

  dynamic _data;

  late ButtonStyle _buttonStyle;

  /// Used to set default [ButtonStyle] for [_buttonStyle]
  ButtonStyle intializeButtonStyle();

  MaterialStatesController? _internalStatesController;

  /// Getter for the current [MaterialStatesController]
  MaterialStatesController get statesController =>
      widget.materialStatesController ?? _internalStatesController!;

  void _initStatesController() {
    if (widget.materialStatesController == null) {
      _internalStatesController = MaterialStatesController();
    }
    statesController.update(MaterialState.disabled, !widget.enabled);
    statesController.addListener(
      () {
        materialStatesUpdater();
      },
    );
  }

  @override
  @mustCallSuper
  void didUpdateWidget(covariant AsyncBtnCore oldWidget) {
    if (widget.switchBackAfterCompletion !=
            oldWidget.switchBackAfterCompletion ||
        widget.switchBackDelay != oldWidget.switchBackDelay ||
        widget.lockWhileAlreadyExecuting !=
            oldWidget.lockWhileAlreadyExecuting ||
        widget.sizeAnimationCurve != oldWidget.sizeAnimationCurve ||
        widget.sizeAnimationClipper != oldWidget.sizeAnimationClipper ||
        widget.sizeAnimationDuration != oldWidget.sizeAnimationDuration ||
        widget.switchInAnimationCurve != oldWidget.switchInAnimationCurve ||
        widget.switchInAnimationDuration !=
            oldWidget.switchInAnimationDuration ||
        widget.switchOutAnimationCurve != oldWidget.switchOutAnimationCurve ||
        widget.switchOutAnimationDuration !=
            oldWidget.switchOutAnimationDuration) {
      _initializeData();
    }

    if (widget.materialStatesController != oldWidget.materialStatesController) {
      oldWidget.materialStatesController?.removeListener(() {
        setState(() {});
      });
      if (widget.materialStatesController != null) {
        _internalStatesController?.dispose();
        _internalStatesController = null;
      }
      _initStatesController();
    }

    if (widget.asyncBtnStatesController != oldWidget.asyncBtnStatesController) {
      oldWidget.asyncBtnStatesController?.removeListener(() {
        setState(() {});
      });
    }

    if (widget.enabled != oldWidget.enabled) {
      statesController.update(MaterialState.disabled, !widget.enabled);
      if (!widget.enabled) {
        // The button may have been disabled while a press gesture is currently underway.
        statesController.update(MaterialState.pressed, false);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initializeData() {
    _buttonStyle = intializeButtonStyle();

    AsyncBtnState nextState = currentButtonState;
    dynamic data = _data;
    switch (nextState) {
      case AsyncBtnState.loading:
        // ButtonStyle? style = (widget.loadingStyleBuilder?.call(data)?.style ??
        //     widget.loadingStyle?.style);
        _backgroundColorTween.begin = _backgroundColorTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.backgroundColor
                ?.resolve(statesController.value);
        _foregroundColorTween.begin = _foregroundColorTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.foregroundColor
                ?.resolve(statesController.value);
        _overlayColorTween.begin = _overlayColorTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.overlayColor
                ?.resolve(statesController.value);
        _elevationTween.begin = _elevationTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.elevation
                ?.resolve(statesController.value);
        _shadowColorTween.begin = _shadowColorTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.shadowColor
                ?.resolve(statesController.value);
        _shapeBorderTween.begin = _shapeBorderTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.shape
                ?.resolve(statesController.value);
        _surfaceTintColorTween.begin = _surfaceTintColorTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.surfaceTintColor
                ?.resolve(statesController.value);

        // textStyleTween.begin = textStyleTween.end = (widget.loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.textStyle?.resolve(statesController.value);
        _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.padding
                ?.resolve(statesController.value);
        _alignmentGeometryTween.begin = _alignmentGeometryTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.alignment;
        // fixedSizeTween.begin = fixedSizeTween.end = (widget.loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.fixedSize?.resolve(statesController.value);
        _minimumSizeTween.begin = _minimumSizeTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.minimumSize
                ?.resolve(statesController.value);
        _maximumSizeTween.begin = _maximumSizeTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.maximumSize
                ?.resolve(statesController.value);
        _borderSideTween.begin = _borderSideTween.end =
            (widget.loadingStyleBuilder?.call(data)?.style ??
                    widget.loadingStyle?.style)
                ?.side
                ?.resolve(statesController.value);
        break;
      case AsyncBtnState.success:
        _backgroundColorTween.begin = _backgroundColorTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.backgroundColor
                ?.resolve(statesController.value);
        _foregroundColorTween.begin = _foregroundColorTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.foregroundColor
                ?.resolve(statesController.value);
        _overlayColorTween.begin = _overlayColorTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.overlayColor
                ?.resolve(statesController.value);
        _elevationTween.begin = _elevationTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.elevation
                ?.resolve(statesController.value);
        _shadowColorTween.begin = _shadowColorTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.shadowColor
                ?.resolve(statesController.value);
        _shapeBorderTween.begin = _shapeBorderTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.shape
                ?.resolve(statesController.value);
        _surfaceTintColorTween.begin = _surfaceTintColorTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.surfaceTintColor
                ?.resolve(statesController.value);

        // textStyleTween.begin = textStyleTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.textStyle?.resolve(statesController.value);
        _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.padding
                ?.resolve(statesController.value);
        _alignmentGeometryTween.begin = _alignmentGeometryTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.alignment;
        // fixedSizeTween.begin = fixedSizeTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.fixedSize?.resolve(statesController.value);
        _minimumSizeTween.begin = _minimumSizeTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.minimumSize
                ?.resolve(statesController.value);
        _maximumSizeTween.begin = _maximumSizeTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.maximumSize
                ?.resolve(statesController.value);
        _borderSideTween.begin = _borderSideTween.end =
            (widget.successStyleBuilder?.call(data)?.style ??
                    widget.successStyle?.style)
                ?.side
                ?.resolve(statesController.value);
        break;
      case AsyncBtnState.failure:
        _backgroundColorTween.begin = _backgroundColorTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.backgroundColor
                ?.resolve(statesController.value);
        _foregroundColorTween.begin = _foregroundColorTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.foregroundColor
                ?.resolve(statesController.value);
        _overlayColorTween.begin = _overlayColorTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.overlayColor
                ?.resolve(statesController.value);
        _elevationTween.begin = _elevationTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.elevation
                ?.resolve(statesController.value);
        _shadowColorTween.begin = _shadowColorTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.shadowColor
                ?.resolve(statesController.value);
        _shapeBorderTween.begin = _shapeBorderTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.shape
                ?.resolve(statesController.value);
        _surfaceTintColorTween.begin = _surfaceTintColorTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.surfaceTintColor
                ?.resolve(statesController.value);

        // textStyleTween.begin = textStyleTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.textStyle?.resolve(statesController.value);
        _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.padding
                ?.resolve(statesController.value);
        _alignmentGeometryTween.begin = _alignmentGeometryTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.alignment;
        // fixedSizeTween.begin = fixedSizeTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.style?.fixedSize?.resolve(statesController.value);
        _minimumSizeTween.begin = _minimumSizeTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.minimumSize
                ?.resolve(statesController.value);
        _maximumSizeTween.begin = _maximumSizeTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.maximumSize
                ?.resolve(statesController.value);
        _borderSideTween.begin = _borderSideTween.end =
            (widget.failureStyleBuilder?.call(data)?.style ??
                    widget.failureStyle?.style)
                ?.side
                ?.resolve(statesController.value);
        break;
      case AsyncBtnState.idle:
        _backgroundColorTween.begin = _backgroundColorTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .backgroundColor
                ?.resolve(statesController.value);
        _foregroundColorTween.begin = _foregroundColorTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .foregroundColor
                ?.resolve(statesController.value);
        _overlayColorTween.begin = _overlayColorTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .overlayColor
                ?.resolve(statesController.value);
        _elevationTween.begin = _elevationTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .elevation
                ?.resolve(statesController.value);
        _shadowColorTween.begin = _shadowColorTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .shadowColor
                ?.resolve(statesController.value);
        _shapeBorderTween.begin = _shapeBorderTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .shape
                ?.resolve(statesController.value);
        _surfaceTintColorTween.begin = _surfaceTintColorTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .surfaceTintColor
                ?.resolve(statesController.value);

        // textStyleTween.begin = textStyleTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.textStyle?.resolve(statesController.value);
        _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .padding
                ?.resolve(statesController.value);
        _alignmentGeometryTween.begin = _alignmentGeometryTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle).alignment;
        // fixedSizeTween.begin = fixedSizeTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.style?.fixedSize?.resolve(statesController.value);
        _minimumSizeTween.begin = _minimumSizeTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .minimumSize
                ?.resolve(statesController.value);
        _maximumSizeTween.begin = _maximumSizeTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .maximumSize
                ?.resolve(statesController.value);
        _borderSideTween.begin = _borderSideTween.end =
            (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                .side
                ?.resolve(statesController.value);
    }

    _backgroundColorTween.begin ??= _backgroundColorTween.end ??=
        _buttonStyle.backgroundColor?.resolve(statesController.value);
    _foregroundColorTween.begin ??= _foregroundColorTween.end ??=
        _buttonStyle.foregroundColor?.resolve(statesController.value);
    _overlayColorTween.begin ??= _overlayColorTween.end ??=
        _buttonStyle.overlayColor?.resolve(statesController.value);
    _elevationTween.begin ??= _elevationTween.end ??=
        _buttonStyle.elevation?.resolve(statesController.value);
    _shadowColorTween.begin ??= _shadowColorTween.end ??=
        _buttonStyle.shadowColor?.resolve(statesController.value);
    _shapeBorderTween.begin ??= _shapeBorderTween.end ??=
        _buttonStyle.shape?.resolve(statesController.value);
    _surfaceTintColorTween.begin ??= _surfaceTintColorTween.end ??=
        _buttonStyle.surfaceTintColor?.resolve(statesController.value);

    // textStyleTween.begin ??= textStyleTween.end ??= _buttonStyle.textStyle?.resolve(statesController.value);
    _egdeInsetsGeometryTween.begin ??= _egdeInsetsGeometryTween.end ??=
        _buttonStyle.padding?.resolve(statesController.value);
    _alignmentGeometryTween.begin ??=
        _alignmentGeometryTween.end ??= _buttonStyle.alignment;
    // fixedSizeTween.begin ??= fixedSizeTween.end ??= _buttonStyle.fixedSize?.resolve(statesController.value);
    _minimumSizeTween.begin ??= _minimumSizeTween.end ??=
        _buttonStyle.minimumSize?.resolve(statesController.value);
    _maximumSizeTween.begin ??= _maximumSizeTween.end ??=
        _buttonStyle.maximumSize?.resolve(statesController.value);
    _borderSideTween.begin ??= _borderSideTween.end ??=
        _buttonStyle.side?.resolve(statesController.value);

    // _backgroundColorTween.begin = _backgroundColorTween.end =
    //     widget.onPressed == null
    //         ? _buttonStyle.backgroundColor?.resolve({MaterialState.disabled})
    //         : _buttonStyle.backgroundColor
    //             ?.resolve(statesController.value);

    // _foregroundColorTween.begin = _foregroundColorTween.end =
    //     widget.onPressed == null
    //         ? _buttonStyle.foregroundColor?.resolve({MaterialState.disabled})
    //         : _buttonStyle.foregroundColor
    //             ?.resolve(statesController.value);

    // _overlayColorTween.begin = _overlayColorTween.end = widget.onPressed == null
    //     ? _buttonStyle.overlayColor?.resolve({MaterialState.disabled})
    //     : _buttonStyle.overlayColor
    //         ?.resolve(statesController.value);

    // _elevationTween.begin = _elevationTween.end = widget.onPressed == null
    //     ? _buttonStyle.elevation?.resolve({MaterialState.disabled})
    //     : _buttonStyle.elevation
    //         ?.resolve(statesController.value);

    // _shadowColorTween.begin = _shadowColorTween.end = widget.onPressed == null
    //     ? _buttonStyle.shadowColor?.resolve({MaterialState.disabled})
    //     : _buttonStyle.shadowColor
    //         ?.resolve(statesController.value);

    // _shapeBorderTween.begin = _shapeBorderTween.end = widget.onPressed == null
    //     ? _buttonStyle.shape?.resolve({MaterialState.disabled})
    //     : _buttonStyle.shape
    //         ?.resolve(statesController.value);

    // _surfaceTintColorTween.begin = _surfaceTintColorTween.end =
    //     widget.onPressed == null
    //         ? _buttonStyle.surfaceTintColor?.resolve({MaterialState.disabled})
    //         : _buttonStyle.surfaceTintColor
    //             ?.resolve(statesController.value);

    // // _textStyleTween.begin = _textStyleTween.end = widget.onPressed == null
    // // ? _buttonStyle.textStyle?.resolve({MaterialState.disabled})
    // // : _buttonStyle.textStyle?.resolve(statesController.value);

    // _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryTween.end =
    //     widget.onPressed == null
    //         ? _buttonStyle.padding?.resolve({MaterialState.disabled})
    //         : _buttonStyle.padding
    //             ?.resolve(statesController.value);

    // _alignmentGeometryTween.begin =
    //     _alignmentGeometryTween.end = _buttonStyle.alignment;

    // // _fixedSizeTween.begin = _fixedSizeTween.end = widget.onPressed == null
    // //     ? _buttonStyle.fixedSize?.resolve({MaterialState.disabled})
    // //     : _buttonStyle.fixedSize?.resolve(statesController.value);

    // _minimumSizeTween.begin = _minimumSizeTween.end = widget.onPressed == null
    //     ? _buttonStyle.minimumSize?.resolve({MaterialState.disabled})
    //     : _buttonStyle.minimumSize
    //         ?.resolve(statesController.value);

    // _maximumSizeTween.begin = _maximumSizeTween.end = widget.onPressed == null
    //     ? _buttonStyle.maximumSize?.resolve({MaterialState.disabled})
    //     : _buttonStyle.maximumSize
    //         ?.resolve(statesController.value);

    // _borderSideTween.begin = _borderSideTween.end = widget.onPressed == null
    //     ? _buttonStyle.side?.resolve({MaterialState.disabled})
    //     : _buttonStyle.side
    //         ?.resolve(statesController.value);
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();
  }

  /// Updates material states changes
  void materialStatesUpdater() {
    if (mounted) {
      AsyncBtnState nextState = currentButtonState;
      dynamic data = _data;
      setState(() {
        // _backgroundColorTween.begin = _backgroundColorAnimation.value;
        // _foregroundColorTween.begin = _foregroundColorAnimation.value;
        // _overlayColorTween.begin = _overlayColorAnimation.value;
        // _elevationTween.begin = _elevationAnimation.value;
        // _shadowColorTween.begin = _shadowColorAnimation.value;
        // _shapeBorderTween.begin = _shapeBorderAnimation.value;
        // _surfaceTintColorTween.begin = _surfaceTintColorAnimation.value;
        // // _textStyleTween.begin = _textStyleAnimation.value;
        // _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryAnimation.value;
        // _alignmentGeometryTween.begin = _alignmentGeometryAnimation.value;
        // // _fixedSizeTween.begin = _fixedSizeAnimation.value;
        // _minimumSizeTween.begin = _minimumSizeAnimation.value;
        // _maximumSizeTween.begin = _maximumSizeAnimation.value;
        // _borderSideTween.begin = _borderSideAnimation.value;

        switch (nextState) {
          case AsyncBtnState.loading:
            _backgroundColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (widget.loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.alignment;
            // fixedSizeTween.end = (widget.loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.side
                    ?.resolve(statesController.value);
            break;
          case AsyncBtnState.success:
            _backgroundColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.alignment;
            // fixedSizeTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.side
                    ?.resolve(statesController.value);
            break;
          case AsyncBtnState.failure:
            _backgroundColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.alignment;
            // fixedSizeTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.style?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.side
                    ?.resolve(statesController.value);
            break;
          case AsyncBtnState.idle:
            _backgroundColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .alignment;
            // fixedSizeTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.style?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .side
                    ?.resolve(statesController.value);
          // break;
          // default:
          //   _backgroundColorTween.end =
          //       _buttonStyle.backgroundColor?.resolve(statesController.value);
          //   _foregroundColorTween.end =
          //       _buttonStyle.foregroundColor?.resolve(statesController.value);
          //   _overlayColorTween.end = _buttonStyle.overlayColor?.resolve(statesController.value);
          //   _elevationTween.end = _buttonStyle.elevation?.resolve(statesController.value);
          //   _shadowColorTween.end = _buttonStyle.shadowColor?.resolve(statesController.value);
          //   _shapeBorderTween.end = _buttonStyle.shape?.resolve(statesController.value);
          //   _surfaceTintColorTween.end =
          //       _buttonStyle.surfaceTintColor?.resolve(statesController.value);

          //   // textStyleTween.end = _buttonStyle.textStyle?.resolve(statesController.value);
          //   _egdeInsetsGeometryTween.end = _buttonStyle.padding?.resolve(statesController.value);
          //   _alignmentGeometryTween.end = _buttonStyle.alignment;
          //   // fixedSizeTween.end = _buttonStyle.fixedSize?.resolve(statesController.value);
          //   _minimumSizeTween.end = _buttonStyle.minimumSize?.resolve(statesController.value);
          //   _maximumSizeTween.end = _buttonStyle.maximumSize?.resolve(statesController.value);
          //   _borderSideTween.end = _buttonStyle.side?.resolve(statesController.value);
        }

        _backgroundColorTween.end ??=
            _buttonStyle.backgroundColor?.resolve(statesController.value);
        _foregroundColorTween.end ??=
            _buttonStyle.foregroundColor?.resolve(statesController.value);
        _overlayColorTween.end ??=
            _buttonStyle.overlayColor?.resolve(statesController.value);
        _elevationTween.end ??=
            _buttonStyle.elevation?.resolve(statesController.value);
        _shadowColorTween.end ??=
            _buttonStyle.shadowColor?.resolve(statesController.value);
        _shapeBorderTween.end ??=
            _buttonStyle.shape?.resolve(statesController.value);
        _surfaceTintColorTween.end ??=
            _buttonStyle.surfaceTintColor?.resolve(statesController.value);

        // textStyleTween.end ??= _buttonStyle.textStyle?.resolve(statesController.value);
        _egdeInsetsGeometryTween.end ??=
            _buttonStyle.padding?.resolve(statesController.value);
        _alignmentGeometryTween.end ??= _buttonStyle.alignment;
        // fixedSizeTween.end ??= _buttonStyle.fixedSize?.resolve(statesController.value);
        _minimumSizeTween.end ??=
            _buttonStyle.minimumSize?.resolve(statesController.value);
        _maximumSizeTween.end ??=
            _buttonStyle.maximumSize?.resolve(statesController.value);
        _borderSideTween.end ??=
            _buttonStyle.side?.resolve(statesController.value);

        if (_animationController.value != 1) {
          _animationController.value = 1;
        }
      });
    }
  }

  /// Handler styles changes
  void stylesUpdater() {
    // Updating with the same button state continously won't have any
    // change in UI as the ValueKey remains the same for the widget.
    // So better to not update.
    if (widget.asyncBtnStatesController?.value?.buttonState ==
        currentButtonState) {
      return;
    }
    if (mounted) {
      AsyncBtnState nextState =
          widget.asyncBtnStatesController?.value?.buttonState ??
              AsyncBtnState.idle;
      dynamic data = widget.asyncBtnStatesController?.value?.data;
      setState(() {
        _backgroundColorTween.begin = _backgroundColorAnimation.value;
        _foregroundColorTween.begin = _foregroundColorAnimation.value;
        _overlayColorTween.begin = _overlayColorAnimation.value;
        _elevationTween.begin = _elevationAnimation.value;
        _shadowColorTween.begin = _shadowColorAnimation.value;
        _shapeBorderTween.begin = _shapeBorderAnimation.value;
        _surfaceTintColorTween.begin = _surfaceTintColorAnimation.value;
        // _textStyleTween.begin = _textStyleAnimation.value;
        _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryAnimation.value;
        _alignmentGeometryTween.begin = _alignmentGeometryAnimation.value;
        // _fixedSizeTween.begin = _fixedSizeAnimation.value;
        _minimumSizeTween.begin = _minimumSizeAnimation.value;
        _maximumSizeTween.begin = _maximumSizeAnimation.value;
        _borderSideTween.begin = _borderSideAnimation.value;

        switch (nextState) {
          case AsyncBtnState.loading:
            _backgroundColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (widget.loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.alignment;
            // fixedSizeTween.end = (widget.loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.loadingStyleBuilder?.call(data)?.style ??
                        widget.loadingStyle?.style)
                    ?.side
                    ?.resolve(statesController.value);
            break;
          case AsyncBtnState.success:
            _backgroundColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.alignment;
            // fixedSizeTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.successStyleBuilder?.call(data)?.style ??
                        widget.successStyle?.style)
                    ?.side
                    ?.resolve(statesController.value);
            break;
          case AsyncBtnState.failure:
            _backgroundColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.alignment;
            // fixedSizeTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.style?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.failureStyleBuilder?.call(data)?.style ??
                        widget.failureStyle?.style)
                    ?.side
                    ?.resolve(statesController.value);
            break;
          case AsyncBtnState.idle:
            _backgroundColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .backgroundColor
                    ?.resolve(statesController.value);
            _foregroundColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .foregroundColor
                    ?.resolve(statesController.value);
            _overlayColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .overlayColor
                    ?.resolve(statesController.value);
            _elevationTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .elevation
                    ?.resolve(statesController.value);
            _shadowColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .shadowColor
                    ?.resolve(statesController.value);
            _shapeBorderTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .shape
                    ?.resolve(statesController.value);
            _surfaceTintColorTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .surfaceTintColor
                    ?.resolve(statesController.value);

            // textStyleTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.textStyle?.resolve(statesController.value);
            _egdeInsetsGeometryTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .padding
                    ?.resolve(statesController.value);
            _alignmentGeometryTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .alignment;
            // fixedSizeTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.style?.fixedSize?.resolve(statesController.value);
            _minimumSizeTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .minimumSize
                    ?.resolve(statesController.value);
            _maximumSizeTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .maximumSize
                    ?.resolve(statesController.value);
            _borderSideTween.end =
                (widget.styleBuilder?.call(data)?.style ?? _buttonStyle)
                    .side
                    ?.resolve(statesController.value);
          // break;
          // default:
          //   _backgroundColorTween.end =
          //       _buttonStyle.backgroundColor?.resolve(statesController.value);
          //   _foregroundColorTween.end =
          //       _buttonStyle.foregroundColor?.resolve(statesController.value);
          //   _overlayColorTween.end = _buttonStyle.overlayColor?.resolve(statesController.value);
          //   _elevationTween.end = _buttonStyle.elevation?.resolve(statesController.value);
          //   _shadowColorTween.end = _buttonStyle.shadowColor?.resolve(statesController.value);
          //   _shapeBorderTween.end = _buttonStyle.shape?.resolve(statesController.value);
          //   _surfaceTintColorTween.end =
          //       _buttonStyle.surfaceTintColor?.resolve(statesController.value);

          //   // textStyleTween.end = _buttonStyle.textStyle?.resolve(statesController.value);
          //   _egdeInsetsGeometryTween.end = _buttonStyle.padding?.resolve(statesController.value);
          //   _alignmentGeometryTween.end = _buttonStyle.alignment;
          //   // fixedSizeTween.end = _buttonStyle.fixedSize?.resolve(statesController.value);
          //   _minimumSizeTween.end = _buttonStyle.minimumSize?.resolve(statesController.value);
          //   _maximumSizeTween.end = _buttonStyle.maximumSize?.resolve(statesController.value);
          //   _borderSideTween.end = _buttonStyle.side?.resolve(statesController.value);
        }

        _backgroundColorTween.end ??=
            _buttonStyle.backgroundColor?.resolve(statesController.value);
        _foregroundColorTween.end ??=
            _buttonStyle.foregroundColor?.resolve(statesController.value);
        _overlayColorTween.end ??=
            _buttonStyle.overlayColor?.resolve(statesController.value);
        _elevationTween.end ??=
            _buttonStyle.elevation?.resolve(statesController.value);
        _shadowColorTween.end ??=
            _buttonStyle.shadowColor?.resolve(statesController.value);
        _shapeBorderTween.end ??=
            _buttonStyle.shape?.resolve(statesController.value);
        _surfaceTintColorTween.end ??=
            _buttonStyle.surfaceTintColor?.resolve(statesController.value);

        // textStyleTween.end ??= _buttonStyle.textStyle?.resolve(statesController.value);
        _egdeInsetsGeometryTween.end ??=
            _buttonStyle.padding?.resolve(statesController.value);
        _alignmentGeometryTween.end ??= _buttonStyle.alignment;
        // fixedSizeTween.end ??= _buttonStyle.fixedSize?.resolve(statesController.value);
        _minimumSizeTween.end ??=
            _buttonStyle.minimumSize?.resolve(statesController.value);
        _maximumSizeTween.end ??=
            _buttonStyle.maximumSize?.resolve(statesController.value);
        _borderSideTween.end ??=
            _buttonStyle.side?.resolve(statesController.value);

        currentButtonState = nextState;
        _data = data;

        _animationController.forward(from: 0);
      });
    }
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _initStatesController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.switchInAnimationDuration,
    );

    currentButtonState = widget.asyncBtnStatesController?.value?.buttonState ??
        AsyncBtnState.idle;
    _data = widget.asyncBtnStatesController?.value?.data;

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    widget.asyncBtnStatesController?.addListener(() {
      stylesUpdater();
    });

    _backgroundColorAnimation =
        _backgroundColorTween.animate(_animationController);
    _foregroundColorAnimation =
        _foregroundColorTween.animate(_animationController);

    _overlayColorAnimation = _overlayColorTween.animate(_animationController);
    _elevationAnimation = _elevationTween.animate(_animationController);
    _shadowColorAnimation = _shadowColorTween.animate(_animationController);
    _shapeBorderAnimation = _shapeBorderTween.animate(_animationController);
    _surfaceTintColorAnimation =
        _surfaceTintColorTween.animate(_animationController);
    // _textStyleAnimation = _textStyleTween.animate(animationController);
    _egdeInsetsGeometryAnimation =
        _egdeInsetsGeometryTween.animate(_animationController);
    _alignmentGeometryAnimation =
        _alignmentGeometryTween.animate(_animationController);
    // _fixedSizeAnimation = _fixedSizeTween.animate(animationController);
    _minimumSizeAnimation = _minimumSizeTween.animate(_animationController);
    _maximumSizeAnimation = _maximumSizeTween.animate(_animationController);
    _borderSideAnimation = _borderSideTween.animate(_animationController);
  }

  @override
  @mustCallSuper
  void dispose() {
    _animationController.removeListener(() {});
    _animationController.dispose();
    statesController.removeListener(() {});
    statesController.dispose();
    widget.asyncBtnStatesController?.removeListener(() {});
    widget.asyncBtnStatesController?.dispose();
    super.dispose();
  }

  Widget _renderButtonChild(AsyncBtnState buttonState) {
    switch (buttonState) {
      case AsyncBtnState.idle:
        Widget? widgetToShow = widget.styleBuilder?.call(_data)?.widget;
        if (widgetToShow != null) {
          return SizedBox(
            key: ValueKey(buttonState.name),
            child: widgetToShow,
          );
        }
        return SizedBox(
          key: ValueKey(buttonState.name),
          child: widget.child,
        );
      case AsyncBtnState.loading:
        Widget? widgetToShow = widget.loadingStyleBuilder?.call(_data)?.widget;
        if (widgetToShow != null) {
          return SizedBox(
            // key: ValueKey(buttonState.name+UniqueKey()),
            key: UniqueKey(),
            child: widgetToShow,
          );
        }
        return widget.loadingStyle?.widget != null
            ? SizedBox(
                key: ValueKey(buttonState.name),
                child: widget.loadingStyle?.widget,
              )
            : _renderButtonChild(AsyncBtnState.idle);
      case AsyncBtnState.success:
        Widget? widgetToShow = widget.successStyleBuilder?.call(_data)?.widget;
        if (widgetToShow != null) {
          return SizedBox(
            key: ValueKey(buttonState.name),
            child: widgetToShow,
          );
        }
        return widget.successStyle?.widget != null
            ? SizedBox(
                key: ValueKey(buttonState.name),
                child: widget.successStyle?.widget,
              )
            : _renderButtonChild(AsyncBtnState.idle);
      case AsyncBtnState.failure:
        Widget? widgetToShow = widget.failureStyleBuilder?.call(_data)?.widget;
        if (widgetToShow != null) {
          return SizedBox(
            key: ValueKey(buttonState.name),
            child: widgetToShow,
          );
        }
        return widget.failureStyle?.widget != null
            ? SizedBox(
                key: ValueKey(buttonState.name),
                child: widget.failureStyle?.widget,
              )
            : _renderButtonChild(AsyncBtnState.idle);
    }
  }

  /// The actual onPressed that is executed when the button is clicked
  void Function()? onPressed() {
    return widget.onPressed == null
        ? null
        : () async {
            if (isExecuting && widget.lockWhileAlreadyExecuting) return;
            isExecuting = true;
            await widget.onPressed?.call();
            if (widget.switchBackAfterCompletion) {
              await Future.delayed(widget.switchBackDelay);
              widget.asyncBtnStatesController?.update(AsyncBtnState.idle);
            }
            isExecuting = false;
          };
  }

  /// The actual onPressed that is executed when the button is clicked and hold
  void Function()? onLongPressed() {
    return widget.onLongPress == null
        ? null
        : () async {
            if (isExecuting && widget.lockWhileAlreadyExecuting) return;
            isExecuting = true;
            await widget.onLongPress?.call();
            if (widget.switchBackAfterCompletion) {
              await Future.delayed(widget.switchBackDelay);
              widget.asyncBtnStatesController?.update(AsyncBtnState.idle);
            }
            isExecuting = false;
          };
  }

  /// Defines the actual [ButtonStyle] to be used in all buttons
  ButtonStyle makeButtonStyle() {
    return _buttonStyle.copyWith(
      backgroundColor:
          MaterialStateProperty.all(_backgroundColorAnimation.value),
      //     () {
      //   MaterialStateProperty<Color?>? getValue(AsyncBtnState buttonState) {
      //     switch (buttonState) {
      //       case AsyncBtnState.idle:
      //         return _buttonStyle.backgroundColor;
      //       case AsyncBtnState.loading:
      //         return (widget.loadingStyleBuilder?.call(_data)?.style ??
      //                     widget.loadingStyle?.style)
      //                 ?.backgroundColor ??
      //             getValue(AsyncBtnState.idle);
      //       case AsyncBtnState.success:
      //         return (widget.successStyleBuilder?.call(_data)?.style ??
      //                     widget.successStyle?.style)
      //                 ?.backgroundColor ??
      //             getValue(AsyncBtnState.idle);
      //       case AsyncBtnState.failure:
      //         return (widget.failureStyleBuilder?.call(_data)?.style ??
      //                     widget.failureStyle?.style)
      //                 ?.backgroundColor ??
      //             getValue(AsyncBtnState.idle);
      //     }
      //   }

      //   return getValue(currentButtonState);
      // }(),
      // foregroundColor:
      //     MaterialStateProperty.all(_foregroundColorAnimation.value),
      foregroundColor: () {
        MaterialStateProperty<Color?>? getValue(AsyncBtnState buttonState) {
          switch (buttonState) {
            case AsyncBtnState.idle:
              return _buttonStyle.foregroundColor;
            case AsyncBtnState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.foregroundColor ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.foregroundColor ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.foregroundColor ??
                  getValue(AsyncBtnState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
      padding: MaterialStateProperty.all(_egdeInsetsGeometryAnimation.value),
      alignment: _alignmentGeometryAnimation.value,
      minimumSize: MaterialStateProperty.all(_minimumSizeAnimation.value),
      maximumSize: MaterialStateProperty.all(_maximumSizeAnimation.value),
      shape: MaterialStateProperty.all(
          _shapeBorderAnimation.value as OutlinedBorder),
      side: MaterialStateProperty.all(_borderSideAnimation.value),
      elevation: MaterialStateProperty.all(_elevationAnimation.value),
      overlayColor: MaterialStateProperty.all(_overlayColorAnimation.value),
      shadowColor: MaterialStateProperty.all(_shadowColorAnimation.value),
      surfaceTintColor:
          MaterialStateProperty.all(_surfaceTintColorAnimation.value),
      mouseCursor: () {
        MaterialStateProperty<MouseCursor?>? getValue(
            AsyncBtnState buttonState) {
          switch (buttonState) {
            case AsyncBtnState.idle:
              return _buttonStyle.mouseCursor;
            case AsyncBtnState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.mouseCursor ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.mouseCursor ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.mouseCursor ??
                  getValue(AsyncBtnState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
      tapTargetSize: () {
        MaterialTapTargetSize? getValue(AsyncBtnState buttonState) {
          switch (buttonState) {
            case AsyncBtnState.idle:
              return _buttonStyle.tapTargetSize;
            case AsyncBtnState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.tapTargetSize ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.tapTargetSize ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.tapTargetSize ??
                  getValue(AsyncBtnState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
      animationDuration: () {
        Duration? getValue(AsyncBtnState buttonState) {
          switch (buttonState) {
            case AsyncBtnState.idle:
              return _buttonStyle.animationDuration;
            case AsyncBtnState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.animationDuration ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.animationDuration ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.animationDuration ??
                  getValue(AsyncBtnState.idle);
          }
        }

        return getValue(currentButtonState) ?? Duration.zero;
      }(),
      enableFeedback: () {
        bool? getValue(AsyncBtnState buttonState) {
          switch (buttonState) {
            case AsyncBtnState.idle:
              return _buttonStyle.enableFeedback;
            case AsyncBtnState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.enableFeedback ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.enableFeedback ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.enableFeedback ??
                  getValue(AsyncBtnState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
      splashFactory: () {
        InteractiveInkFeatureFactory? getValue(AsyncBtnState buttonState) {
          switch (buttonState) {
            case AsyncBtnState.idle:
              return _buttonStyle.splashFactory;
            case AsyncBtnState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.splashFactory ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.splashFactory ??
                  getValue(AsyncBtnState.idle);
            case AsyncBtnState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.splashFactory ??
                  getValue(AsyncBtnState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
    );
  }

  /// The core button widget
  ButtonStyleButton makeButton(Widget child);

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return makeButton(AnimatedSize(
      duration: widget.sizeAnimationDuration,
      clipBehavior: widget.sizeAnimationClipper,
      curve: widget.sizeAnimationCurve,
      child: AnimatedSwitcher(
        layoutBuilder: widget.layoutBuilder,
        switchInCurve: widget.switchInAnimationCurve,
        switchOutCurve: widget.switchInAnimationCurve,
        duration: widget.switchInAnimationDuration,
        transitionBuilder: widget.transitionBuilder,
        reverseDuration: widget.switchOutAnimationDuration,
        child: _renderButtonChild(currentButtonState),
      ),
    ));
  }
}
