import 'package:flutter/material.dart';

import '../helpers/custom_border_side_tween.dart';
import '../helpers/async_button_state_style.dart';
import '../helpers/constants.dart';

// ? Why some of the code is commented?
// * It was noticed that many of the button style attributes didn't need any
// * [Animation]/[Tween] object to animate between [ButtonState] states. Therefore, it
// * didn't made sense to use them. The commented code is only meant to show what
// * styles were tested and may get deleted in the future.

/// Base abstract used to control current [ButtonState] change animations
abstract class AsyncButtonStateController {
  /// A controller for an animation
  final AnimationController animationController;

  /// An animation with a value of type [Color] associated with [ButtonStyle.backgroundColor]
  final Animation<Color?> backgroundColorAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.foregroundColor]
  final Animation<Color?> foregroundColorAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.overlayColor]
  final Animation<Color?> overlayColorAnimation;

  /// An animation with a value of type [double] associated with [ButtonStyle.elevation]
  final Animation<double?> elevationAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.shadowColor]
  final Animation<Color?> shadowColorAnimation;

  /// An animation with a value of type [ShapeBorder] associated with [ButtonStyle.shape]
  final Animation<ShapeBorder?> shapeBorderAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.surfaceTintColor]
  final Animation<Color?> surfaceTintColorAnimation;

  // final Animation<Size?> fixedSizeAnimation;
  // final Animation<TextStyle?> textStyleAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.padding]
  final Animation<EdgeInsetsGeometry?> edgeInsetsGeometryAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.alignment]
  final Animation<AlignmentGeometry?> alignmentGeometryAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.minimumSize]
  final Animation<Size?> minimumSizeAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.maximumSize]
  final Animation<Size?> maximumSizeAnimation;

  /// An animation with a value of type [Color] associated with [ButtonStyle.side]
  final Animation<BorderSide?> borderSideAnimation;

  /// An interpolation between two colors, associated with [backgroundColorAnimation]
  final ColorTween backgroundColorTween;

  /// An interpolation between two colors, associated with [foregroundColorAnimation]
  final ColorTween foregroundColorTween;

  /// An interpolation between two colors, associated with [overlayColorAnimation]
  final ColorTween overlayColorTween;

  /// An interpolation between two [double]s, associated with [elevationAnimation]
  final Tween<double> elevationTween;

  /// An interpolation between two colors, associated with [shadowColorAnimation]
  final ColorTween shadowColorTween;

  /// An interpolation between two [ShapeBorder]s, associated with [shapeBorderAnimation]
  final ShapeBorderTween shapeBorderTween;

  /// An interpolation between two colors, associated with [surfaceTintColorAnimation]
  final ColorTween surfaceTintColorTween;

  // final SizeTween fixedSizeTween;
  // final TextStyleTween textStyleTween;

  /// An interpolation between two [EdgeInsetsGeometry]s, associated with [edgeInsetsGeometryAnimation]
  final EdgeInsetsGeometryTween edgeInsetsGeometryTween;

  /// An interpolation between two [AlignmentGeometry]s, associated with [alignmentGeometryAnimation]
  final AlignmentGeometryTween alignmentGeometryTween;

  /// An interpolation between two sizes, associated with [minimumSizeAnimation]
  final SizeTween minimumSizeTween;

  /// An interpolation between two sizes, associated with [maximumSizeAnimation]
  final SizeTween maximumSizeTween;

  /// An interpolation between two sizes, associated with [borderSideTween]
  final CustomBorderSideTween borderSideTween;

  /// Associated with default [ButtonStyle] appearance
  final ButtonStyle buttonStyle;

  /// Associated with button's [ButtonState], when it is [ButtonState.loading]
  final AsyncButtonStateStyle? loadingStyle;

  /// Same as [loadingStyle], but the result is generated at runtime.
  ///
  /// If the resulting style is not null, it takes precedence over [loadingStyle]
  final AsyncButtonStateStyle? Function(dynamic data)? loadingStyleBuilder;

  /// Associated with button's [ButtonState], when it is [ButtonState.success]
  final AsyncButtonStateStyle? successStyle;

  /// Same as [successStyle], but the result is generated at runtime.
  ///
  /// If the resulting style is not null, it takes precedence over [successStyle]
  final AsyncButtonStateStyle? Function(dynamic data)? successStyleBuilder;

  /// Associated with button's [ButtonState], when it is [ButtonState.failure]
  final AsyncButtonStateStyle? failureStyle;

  /// Same as [failureStyle], but the result is generated at runtime.
  ///
  /// If the resulting style is not null, it takes precedence over [failureStyle]
  final AsyncButtonStateStyle? Function(dynamic data)? failureStyleBuilder;

  /// Function to execute after [update]
  final void Function(ButtonState updatedBtnState, dynamic data)
      postUpdateCallback;

  /// Function to check if the widget is currently mounted or not
  final bool Function() mountedFinder;

  /// Creates an [AsyncButtonStateController]
  AsyncButtonStateController({
    required this.animationController,
    required this.backgroundColorAnimation,
    required this.foregroundColorAnimation,
    required this.overlayColorAnimation,
    required this.elevationAnimation,
    required this.shadowColorAnimation,
    required this.shapeBorderAnimation,
    required this.surfaceTintColorAnimation,
    // required this.fixedSizeAnimation,
    // required this.textStyleAnimation,
    required this.edgeInsetsGeometryAnimation,
    required this.alignmentGeometryAnimation,
    required this.minimumSizeAnimation,
    required this.maximumSizeAnimation,
    required this.borderSideAnimation,

    //
    required this.backgroundColorTween,
    required this.foregroundColorTween,
    required this.overlayColorTween,
    required this.elevationTween,
    required this.shadowColorTween,
    required this.shapeBorderTween,
    required this.surfaceTintColorTween,
    // required this.fixedSizeTween,
    // required this.textStyleTween,
    required this.edgeInsetsGeometryTween,
    required this.alignmentGeometryTween,
    required this.minimumSizeTween,
    required this.maximumSizeTween,
    required this.borderSideTween,

    //
    required this.buttonStyle,
    required this.loadingStyle,
    required this.loadingStyleBuilder,
    required this.successStyle,
    required this.successStyleBuilder,
    required this.failureStyle,
    required this.failureStyleBuilder,

    //
    required this.postUpdateCallback,
    required this.mountedFinder,
  });

  /// Updates the button's current [ButtonState] to [nextState]
  /// [data] is relevant, if you are using [failureStyleBuilder]
  void update(ButtonState nextState, {dynamic data}) {
    backgroundColorTween.begin = backgroundColorAnimation.value;
    foregroundColorTween.begin = foregroundColorAnimation.value;
    overlayColorTween.begin = overlayColorAnimation.value;
    elevationTween.begin = elevationAnimation.value;
    shadowColorTween.begin = shadowColorAnimation.value;
    shapeBorderTween.begin = shapeBorderAnimation.value;
    surfaceTintColorTween.begin = surfaceTintColorAnimation.value;
    // textStyleTween.begin = textStyleAnimation.value;
    edgeInsetsGeometryTween.begin = edgeInsetsGeometryAnimation.value;
    alignmentGeometryTween.begin = alignmentGeometryAnimation.value;
    // fixedSizeTween.begin = fixedSizeAnimation.value;
    minimumSizeTween.begin = minimumSizeAnimation.value;
    maximumSizeTween.begin = maximumSizeAnimation.value;
    borderSideTween.begin = borderSideAnimation.value;

    switch (nextState) {
      case ButtonState.disabled:
        backgroundColorTween.end =
            buttonStyle.backgroundColor?.resolve({MaterialState.disabled});
        foregroundColorTween.end =
            buttonStyle.foregroundColor?.resolve({MaterialState.disabled});
        overlayColorTween.end =
            buttonStyle.overlayColor?.resolve({MaterialState.disabled});
        elevationTween.end =
            buttonStyle.elevation?.resolve({MaterialState.disabled});
        shadowColorTween.end =
            buttonStyle.shadowColor?.resolve({MaterialState.disabled});
        shapeBorderTween.end =
            buttonStyle.shape?.resolve({MaterialState.disabled});
        surfaceTintColorTween.end =
            buttonStyle.surfaceTintColor?.resolve({MaterialState.disabled});

        // textStyleTween.end =
        // buttonStyle.textStyle?.resolve({MaterialState.disabled});
        edgeInsetsGeometryTween.end =
            buttonStyle.padding?.resolve({MaterialState.disabled});
        alignmentGeometryTween.end = buttonStyle.alignment;
        // fixedSizeTween.end =
        //     buttonStyle.fixedSize?.resolve({MaterialState.disabled});
        minimumSizeTween.end =
            buttonStyle.minimumSize?.resolve({MaterialState.disabled});
        maximumSizeTween.end =
            buttonStyle.maximumSize?.resolve({MaterialState.disabled});
        borderSideTween.end =
            buttonStyle.side?.resolve({MaterialState.disabled});
        break;
      case ButtonState.loading:
        backgroundColorTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.backgroundColor
                ?.resolve({});
        foregroundColorTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.foregroundColor
                ?.resolve({});
        overlayColorTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.overlayColor
                ?.resolve({});
        elevationTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.elevation
                ?.resolve({});
        shadowColorTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.shadowColor
                ?.resolve({});
        shapeBorderTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.shape
                ?.resolve({});
        surfaceTintColorTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.surfaceTintColor
                ?.resolve({});

        // textStyleTween.end = (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.textStyle?.resolve({});
        edgeInsetsGeometryTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.padding
                ?.resolve({});
        alignmentGeometryTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.alignment;
        // fixedSizeTween.end = (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)?.fixedSize?.resolve({});
        minimumSizeTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.minimumSize
                ?.resolve({});
        maximumSizeTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.maximumSize
                ?.resolve({});
        borderSideTween.end =
            (loadingStyleBuilder?.call(data)?.style ?? loadingStyle?.style)
                ?.side
                ?.resolve({});
        break;
      case ButtonState.success:
        backgroundColorTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.backgroundColor
                ?.resolve({});
        foregroundColorTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.foregroundColor
                ?.resolve({});
        overlayColorTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.overlayColor
                ?.resolve({});
        elevationTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.elevation
                ?.resolve({});
        shadowColorTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.shadowColor
                ?.resolve({});
        shapeBorderTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.shape
                ?.resolve({});
        surfaceTintColorTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.surfaceTintColor
                ?.resolve({});

        // textStyleTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.textStyle?.resolve({});
        edgeInsetsGeometryTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.padding
                ?.resolve({});
        alignmentGeometryTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.alignment;
        // fixedSizeTween.end = (successStyleBuilder?.call(data)?.style ?? successStyle?.style)?.fixedSize?.resolve({});
        minimumSizeTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.minimumSize
                ?.resolve({});
        maximumSizeTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.maximumSize
                ?.resolve({});
        borderSideTween.end =
            (successStyleBuilder?.call(data)?.style ?? successStyle?.style)
                ?.side
                ?.resolve({});
        break;
      case ButtonState.failure:
        backgroundColorTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.backgroundColor
                ?.resolve({});
        foregroundColorTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.foregroundColor
                ?.resolve({});
        overlayColorTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.overlayColor
                ?.resolve({});
        elevationTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.elevation
                ?.resolve({});
        shadowColorTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.shadowColor
                ?.resolve({});
        shapeBorderTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.shape
                ?.resolve({});
        surfaceTintColorTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.surfaceTintColor
                ?.resolve({});

        // textStyleTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.textStyle?.resolve({});
        edgeInsetsGeometryTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.padding
                ?.resolve({});
        alignmentGeometryTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.alignment;
        // fixedSizeTween.end = (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)?.style?.fixedSize?.resolve({});
        minimumSizeTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.minimumSize
                ?.resolve({});
        maximumSizeTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.maximumSize
                ?.resolve({});
        borderSideTween.end =
            (failureStyleBuilder?.call(data)?.style ?? failureStyle?.style)
                ?.side
                ?.resolve({});
        break;
      default:
        backgroundColorTween.end = buttonStyle.backgroundColor?.resolve({});
        foregroundColorTween.end = buttonStyle.foregroundColor?.resolve({});
        overlayColorTween.end = buttonStyle.overlayColor?.resolve({});
        elevationTween.end = buttonStyle.elevation?.resolve({});
        shadowColorTween.end = buttonStyle.shadowColor?.resolve({});
        shapeBorderTween.end = buttonStyle.shape?.resolve({});
        surfaceTintColorTween.end = buttonStyle.surfaceTintColor?.resolve({});

        // textStyleTween.end = buttonStyle.textStyle?.resolve({});
        edgeInsetsGeometryTween.end = buttonStyle.padding?.resolve({});
        alignmentGeometryTween.end = buttonStyle.alignment;
        // fixedSizeTween.end = buttonStyle.fixedSize?.resolve({});
        minimumSizeTween.end = buttonStyle.minimumSize?.resolve({});
        maximumSizeTween.end = buttonStyle.maximumSize?.resolve({});
        borderSideTween.end = buttonStyle.side?.resolve({});
    }

    backgroundColorTween.end ??= buttonStyle.backgroundColor?.resolve({});
    foregroundColorTween.end ??= buttonStyle.foregroundColor?.resolve({});
    overlayColorTween.end ??= buttonStyle.overlayColor?.resolve({});
    elevationTween.end ??= buttonStyle.elevation?.resolve({});
    shadowColorTween.end ??= buttonStyle.shadowColor?.resolve({});
    shapeBorderTween.end ??= buttonStyle.shape?.resolve({});
    surfaceTintColorTween.end ??= buttonStyle.surfaceTintColor?.resolve({});

    // textStyleTween.end ??= buttonStyle.textStyle?.resolve({});
    edgeInsetsGeometryTween.end ??= buttonStyle.padding?.resolve({});
    alignmentGeometryTween.end ??= buttonStyle.alignment;
    // fixedSizeTween.end ??= buttonStyle.fixedSize?.resolve({});
    minimumSizeTween.end ??= buttonStyle.minimumSize?.resolve({});
    maximumSizeTween.end ??= buttonStyle.maximumSize?.resolve({});
    borderSideTween.end ??= buttonStyle.side?.resolve({});

    if (mountedFinder()) {
      animationController.forward(from: 0);
    }
    postUpdateCallback(nextState, data);
  }
}
