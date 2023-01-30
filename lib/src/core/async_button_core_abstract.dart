import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../source/helpers/custom_border_side_tween.dart';
import '../helpers/async_button_state_style.dart';
import '../helpers/constants.dart';
import 'async_button_state_controller_abstract.dart';
import 'async_button_state_controller_impl.dart';

/// Base abstract class for creating async button
abstract class AsyncButtonCore extends StatefulWidget {
  /// creates an [AsyncButtonCore]
  const AsyncButtonCore({
    Key? key,
    required this.child,
    this.loadingStyle,
    this.loadingStyleBuilder,
    this.successStyle,
    this.successStyleBuilder,
    this.failureStyle,
    this.failureStyleBuilder,
    this.style,
    required this.onPressed,
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
  /// or when current [ButtonState] has changed.
  ///
  /// To change the kind of transition used, see [transitionBuilder].
  final Widget child;

  /// Defines the corresponding style for if button's current [ButtonState] is
  /// [ButtonState.loading]
  ///
  /// Can be null, in which case, uses the [style] and [child] instead.
  final AsyncButtonStateStyle? loadingStyle;

  /// Same as [loadingStyle] but the result is generated at runtime.
  ///
  /// If the result is not null, it takes precedence over [loadingStyle].
  final AsyncButtonStateStyle? Function(dynamic data)? loadingStyleBuilder;

  /// Defines the corresponding style for if button's current [ButtonState] is
  /// [ButtonState.success]
  ///
  /// Can be null, in which case, uses the [style] and [child] instead.
  final AsyncButtonStateStyle? successStyle;

  /// Same as [successStyle] but the result is generated at runtime.
  ///
  /// If the result is not null, it takes precedence over [successStyle].
  final AsyncButtonStateStyle? Function(dynamic data)? successStyleBuilder;

  /// Defines the corresponding style for if button's current [ButtonState] is
  /// [ButtonState.failure]
  ///
  /// Can be null, in which case, uses the [style] and [child] instead.
  final AsyncButtonStateStyle? failureStyle;

  /// Same as [failureStyle] but the result is generated at runtime.
  ///
  /// If the result is not null, it takes precedence over [failureStyle].
  final AsyncButtonStateStyle? Function(dynamic data)? failureStyleBuilder;

  /// Defines the default appearance of the button.
  ///
  /// Can be null, in which case, uses the [ButtonStyle] from current [Theme]
  final ButtonStyle? style;

  /// Executed when the button is pressed, can be null
  final Future<void> Function(AsyncButtonStateController btnStateController)?
      onPressed;

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
  /// The default is [AsyncButtonCore.defaultLayoutBuilder].
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
  /// The default is [AsyncButtonCore.defaultTransitionBuilder].
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
}

/// Implements the [State] for [AsyncButtonCore]
abstract class AsyncButtonCoreState extends State<AsyncButtonCore>
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

  /// Keeps track of whether [AsyncButtonCore.onPressed] is currently executing
  bool isExecuting = false;

  /// Keeps track of current [ButtonState]
  ButtonState currentButtonState = ButtonState.idle;

  dynamic _data;

  late ButtonStyle _buttonStyle;

  /// Used to set default [ButtonStyle] for [_buttonStyle]
  ButtonStyle intializeButtonStyle();

  @override
  @mustCallSuper
  void didUpdateWidget(covariant AsyncButtonCore oldWidget) {
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
    super.didUpdateWidget(oldWidget);
  }

  void _initializeData() {
    _buttonStyle = intializeButtonStyle();
    _backgroundColorTween.begin = _backgroundColorTween.end =
        widget.onPressed == null
            ? _buttonStyle.backgroundColor?.resolve({MaterialState.disabled})
            : _buttonStyle.backgroundColor?.resolve({});

    _foregroundColorTween.begin = _foregroundColorTween.end =
        widget.onPressed == null
            ? _buttonStyle.foregroundColor?.resolve({MaterialState.disabled})
            : _buttonStyle.foregroundColor?.resolve({});

    _overlayColorTween.begin = _overlayColorTween.end = widget.onPressed == null
        ? _buttonStyle.overlayColor?.resolve({MaterialState.disabled})
        : _buttonStyle.overlayColor?.resolve({});

    _elevationTween.begin = _elevationTween.end = widget.onPressed == null
        ? _buttonStyle.elevation?.resolve({MaterialState.disabled})
        : _buttonStyle.elevation?.resolve({});

    _shadowColorTween.begin = _shadowColorTween.end = widget.onPressed == null
        ? _buttonStyle.shadowColor?.resolve({MaterialState.disabled})
        : _buttonStyle.shadowColor?.resolve({});

    _shapeBorderTween.begin = _shapeBorderTween.end = widget.onPressed == null
        ? _buttonStyle.shape?.resolve({MaterialState.disabled})
        : _buttonStyle.shape?.resolve({});

    _surfaceTintColorTween.begin = _surfaceTintColorTween.end =
        widget.onPressed == null
            ? _buttonStyle.surfaceTintColor?.resolve({MaterialState.disabled})
            : _buttonStyle.surfaceTintColor?.resolve({});

    // _textStyleTween.begin = _textStyleTween.end = widget.onPressed == null
    // ? buttonStyle.textStyle?.resolve({MaterialState.disabled})
    // : buttonStyle.textStyle?.resolve({});

    _egdeInsetsGeometryTween.begin = _egdeInsetsGeometryTween.end =
        widget.onPressed == null
            ? _buttonStyle.padding?.resolve({MaterialState.disabled})
            : _buttonStyle.padding?.resolve({});

    _alignmentGeometryTween.begin =
        _alignmentGeometryTween.end = _buttonStyle.alignment;

    // _fixedSizeTween.begin = _fixedSizeTween.end = widget.onPressed == null
    //     ? buttonStyle.fixedSize?.resolve({MaterialState.disabled})
    //     : buttonStyle.fixedSize?.resolve({});

    _minimumSizeTween.begin = _minimumSizeTween.end = widget.onPressed == null
        ? _buttonStyle.minimumSize?.resolve({MaterialState.disabled})
        : _buttonStyle.minimumSize?.resolve({});

    _maximumSizeTween.begin = _maximumSizeTween.end = widget.onPressed == null
        ? _buttonStyle.maximumSize?.resolve({MaterialState.disabled})
        : _buttonStyle.maximumSize?.resolve({});

    _borderSideTween.begin = _borderSideTween.end = widget.onPressed == null
        ? _buttonStyle.side?.resolve({MaterialState.disabled})
        : _buttonStyle.side?.resolve({});
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.switchInAnimationDuration,
    );

    currentButtonState =
        widget.onPressed == null ? ButtonState.disabled : ButtonState.idle;

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
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
    super.dispose();
  }

  Widget _renderButtonChild(ButtonState buttonState) {
    switch (buttonState) {
      case ButtonState.disabled:
        return SizedBox(
          key: ValueKey(ButtonState.idle.name),
          child: widget.child,
        );
      case ButtonState.idle:
        return SizedBox(
          key: ValueKey(ButtonState.idle.name),
          child: widget.child,
        );
      case ButtonState.loading:
        if (widget.loadingStyleBuilder?.call(_data)?.widget != null) {
          return SizedBox(
            key: ValueKey(buttonState.name),
            child: widget.loadingStyleBuilder?.call(_data)?.widget,
          );
        }
        return widget.loadingStyle?.widget != null
            ? SizedBox(
                key: ValueKey(buttonState.name),
                child: widget.loadingStyle?.widget,
              )
            : _renderButtonChild(ButtonState.idle);
      case ButtonState.success:
        if (widget.successStyleBuilder?.call(_data)?.widget != null) {
          return SizedBox(
            key: ValueKey(buttonState.name),
            child: widget.successStyleBuilder!.call(_data)?.widget,
          );
        }
        return widget.successStyle?.widget != null
            ? SizedBox(
                key: ValueKey(buttonState.name),
                child: widget.successStyle?.widget,
              )
            : _renderButtonChild(ButtonState.idle);
      case ButtonState.failure:
        if (widget.failureStyleBuilder?.call(_data)?.widget != null) {
          return SizedBox(
            key: ValueKey(buttonState.name),
            child: widget.failureStyleBuilder!.call(_data)?.widget,
          );
        }
        return widget.failureStyle?.widget != null
            ? SizedBox(
                key: ValueKey(buttonState.name),
                child: widget.failureStyle?.widget,
              )
            : _renderButtonChild(ButtonState.idle);
    }
  }

  /// The actual onPressed that is executed when the button is clicked
  void Function()? onPressed() {
    return widget.onPressed == null
        ? null
        : () async {
            if (isExecuting && widget.lockWhileAlreadyExecuting) return;
            final controller = MainAsyncButtonStateController(
              animationController: _animationController,
              backgroundColorAnimation: _backgroundColorAnimation,
              foregroundColorAnimation: _foregroundColorAnimation,
              overlayColorAnimation: _overlayColorAnimation,
              elevationAnimation: _elevationAnimation,
              shadowColorAnimation: _shadowColorAnimation,
              shapeBorderAnimation: _shapeBorderAnimation,
              surfaceTintColorAnimation: _surfaceTintColorAnimation,
              // fixedSizeAnimation: _fixedSizeAnimation,
              // textStyleAnimation: _textStyleAnimation,
              edgeInsetsGeometryAnimation: _egdeInsetsGeometryAnimation,
              alignmentGeometryAnimation: _alignmentGeometryAnimation,
              minimumSizeAnimation: _minimumSizeAnimation,
              maximumSizeAnimation: _maximumSizeAnimation,
              borderSideAnimation: _borderSideAnimation,

              //
              backgroundColorTween: _backgroundColorTween,
              foregroundColorTween: _foregroundColorTween,
              overlayColorTween: _overlayColorTween,
              elevationTween: _elevationTween,
              shadowColorTween: _shadowColorTween,
              shapeBorderTween: _shapeBorderTween,
              surfaceTintColorTween: _surfaceTintColorTween,
              // fixedSizeTween: _fixedSizeTween,
              // textStyleTween: _textStyleTween,
              edgeInsetsGeometryTween: _egdeInsetsGeometryTween,
              alignmentGeometryTween: _alignmentGeometryTween,
              minimumSizeTween: _minimumSizeTween,
              maximumSizeTween: _maximumSizeTween,
              borderSideTween: _borderSideTween,

              //
              buttonStyle: _buttonStyle,
              loadingStyle: widget.loadingStyle,
              loadingStyleBuilder: widget.loadingStyleBuilder,
              successStyle: widget.successStyle,
              successStyleBuilder: widget.successStyleBuilder,
              failureStyle: widget.failureStyle,
              failureStyleBuilder: widget.failureStyleBuilder,
              postUpdateCallback: (updatedBtnState, data) {
                currentButtonState = updatedBtnState;
                _data = data;
              },
              mountedFinder: () => mounted,
            );
            isExecuting = true;
            await widget.onPressed?.call(controller);
            if (widget.switchBackAfterCompletion) {
              await Future.delayed(widget.switchBackDelay);
              if (mounted) {
                controller.update(ButtonState.idle);
              }
            }
            isExecuting = false;
          };
  }

  /// Defines the actual [ButtonStyle] to be used in all buttons
  ButtonStyle makeButtonStyle() {
    return _buttonStyle.copyWith(
      backgroundColor:
          MaterialStateProperty.all(_backgroundColorAnimation.value),
      foregroundColor:
          MaterialStateProperty.all(_foregroundColorAnimation.value),
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
        MaterialStateProperty<MouseCursor?>? getValue(ButtonState buttonState) {
          switch (buttonState) {
            case ButtonState.disabled:
              return widget.style?.mouseCursor;
            case ButtonState.idle:
              return widget.style?.mouseCursor;
            case ButtonState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.mouseCursor ??
                  getValue(ButtonState.idle);
            case ButtonState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.mouseCursor ??
                  getValue(ButtonState.idle);
            case ButtonState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.mouseCursor ??
                  getValue(ButtonState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
      tapTargetSize: () {
        MaterialTapTargetSize? getValue(ButtonState buttonState) {
          switch (buttonState) {
            case ButtonState.disabled:
              return widget.style?.tapTargetSize;
            case ButtonState.idle:
              return widget.style?.tapTargetSize;
            case ButtonState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.tapTargetSize ??
                  getValue(ButtonState.idle);
            case ButtonState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.tapTargetSize ??
                  getValue(ButtonState.idle);
            case ButtonState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.tapTargetSize ??
                  getValue(ButtonState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
      animationDuration: () {
        Duration? getValue(ButtonState buttonState) {
          switch (buttonState) {
            case ButtonState.disabled:
              return widget.style?.animationDuration;
            case ButtonState.idle:
              return widget.style?.animationDuration;
            case ButtonState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.animationDuration ??
                  getValue(ButtonState.idle);
            case ButtonState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.animationDuration ??
                  getValue(ButtonState.idle);
            case ButtonState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.animationDuration ??
                  getValue(ButtonState.idle);
          }
        }

        return getValue(currentButtonState) ?? Duration.zero;
      }(),
      enableFeedback: () {
        bool? getValue(ButtonState buttonState) {
          switch (buttonState) {
            case ButtonState.disabled:
              return widget.style?.enableFeedback;
            case ButtonState.idle:
              return widget.style?.enableFeedback;
            case ButtonState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.enableFeedback ??
                  getValue(ButtonState.idle);
            case ButtonState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.enableFeedback ??
                  getValue(ButtonState.idle);
            case ButtonState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.enableFeedback ??
                  getValue(ButtonState.idle);
          }
        }

        return getValue(currentButtonState);
      }(),
      splashFactory: () {
        InteractiveInkFeatureFactory? getValue(ButtonState buttonState) {
          switch (buttonState) {
            case ButtonState.disabled:
              return widget.style?.splashFactory;
            case ButtonState.idle:
              return widget.style?.splashFactory;
            case ButtonState.loading:
              return (widget.loadingStyleBuilder?.call(_data)?.style ??
                          widget.loadingStyle?.style)
                      ?.splashFactory ??
                  getValue(ButtonState.idle);
            case ButtonState.success:
              return (widget.successStyleBuilder?.call(_data)?.style ??
                          widget.successStyle?.style)
                      ?.splashFactory ??
                  getValue(ButtonState.idle);
            case ButtonState.failure:
              return (widget.failureStyleBuilder?.call(_data)?.style ??
                          widget.failureStyle?.style)
                      ?.splashFactory ??
                  getValue(ButtonState.idle);
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
