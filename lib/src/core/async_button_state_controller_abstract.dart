import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../helpers/async_button_state_style.dart';

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

  // final Animation<Color?> overlayColorAnimation;
  // final Animation<double?> elevationAnimation;
  // final Animation<Color?> shadowColorAnimation;
  // final Animation<ShapeBorder?> shapeBorderAnimation;

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

  /// An interpolation between two colors, associated with [backgroundColorAnimation]
  final ColorTween backgroundColorTween;

  /// An interpolation between two colors, associated with [foregroundColorAnimation]
  final ColorTween foregroundColorTween;
  // final ColorTween overlayColorTween;
  // final Tween<double> elevationTween;
  // final ColorTween shadowColorTween;
  // final ShapeBorderTween shapeBorderTween;

  /// An interpolation between two colors, associated with [surfaceTintColorAnimation]
  final ColorTween surfaceTintColorTween;
  // final SizeTween fixedSizeTween;
  // final TextStyleTween textStyleTween;
  // final TextStyleTween textStyleTween;

  /// An interpolation between two [EdgeInsetsGeometry]s, associated with [edgeInsetsGeometryAnimation]
  final EdgeInsetsGeometryTween edgeInsetsGeometryTween;

  /// An interpolation between two [AlignmentGeometry]s, associated with [alignmentGeometryAnimation]
  final AlignmentGeometryTween alignmentGeometryTween;

  /// An interpolation between two sizes, associated with [minimumSizeAnimation]
  final SizeTween minimumSizeTween;

  /// An interpolation between two sizes, associated with [maximumSizeAnimation]
  final SizeTween maximumSizeTween;

  /// Associated with default [ButtonStyle] appearance
  final ButtonStyle buttonStyle;

  /// Associated with button's [ButtonState], when it is [ButtonState.loading]
  final AsyncButtonStateStyle? loadingStyle;

  /// Associated with button's [ButtonState], when it is [ButtonState.success]
  final AsyncButtonStateStyle? successStyle;

  /// Associated with button's [ButtonState], when it is [ButtonState.failure]
  final AsyncButtonStateStyle? failureStyle;

  /// Function to execute after [update]
  final void Function(ButtonState updatedBtnState) postUpdateCallback;

  /// Creates an [AsyncButtonStateController]
  AsyncButtonStateController({
    required this.animationController,
    required this.backgroundColorAnimation,
    required this.foregroundColorAnimation,
    // required this.overlayColorAnimation,
    // required this.elevationAnimation,
    // required this.shadowColorAnimation,
    // required this.shapeBorderAnimation,
    required this.surfaceTintColorAnimation,
    // required this.fixedSizeAnimation,
    // required this.textStyleAnimation,
    required this.edgeInsetsGeometryAnimation,
    required this.alignmentGeometryAnimation,
    required this.minimumSizeAnimation,
    required this.maximumSizeAnimation,
    required this.backgroundColorTween,
    required this.foregroundColorTween,
    // required this.overlayColorTween,
    // required this.elevationTween,
    // required this.shadowColorTween,
    // required this.shapeBorderTween,
    required this.surfaceTintColorTween,
    // required this.fixedSizeTween,
    // required this.textStyleTween,
    required this.edgeInsetsGeometryTween,
    required this.alignmentGeometryTween,
    required this.minimumSizeTween,
    required this.maximumSizeTween,
    required this.buttonStyle,
    required this.loadingStyle,
    required this.successStyle,
    required this.failureStyle,
    required this.postUpdateCallback,
  });

  /// Updates the button's current [ButtonState] to [nextState]
  void update(ButtonState nextState) {
    backgroundColorTween.begin = backgroundColorAnimation.value;
    foregroundColorTween.begin = foregroundColorAnimation.value;
    // overlayColorTween.begin = overlayColorAnimation.value;
    // elevationTween.begin = elevationAnimation.value;
    // shadowColorTween.begin = shadowColorAnimation.value;
    // shapeBorderTween.begin = shapeBorderAnimation.value;
    surfaceTintColorTween.begin = surfaceTintColorAnimation.value;
    // textStyleTween.begin = textStyleAnimation.value;
    edgeInsetsGeometryTween.begin = edgeInsetsGeometryAnimation.value;
    alignmentGeometryTween.begin = alignmentGeometryAnimation.value;
    // fixedSizeTween.begin = fixedSizeAnimation.value;
    minimumSizeTween.begin = minimumSizeAnimation.value;
    maximumSizeTween.begin = maximumSizeAnimation.value;

    switch (nextState) {
      case ButtonState.disabled:
        backgroundColorTween.end =
            buttonStyle.backgroundColor?.resolve({MaterialState.disabled});
        foregroundColorTween.end =
            buttonStyle.foregroundColor?.resolve({MaterialState.disabled});
        // overlayColorTween.end =
        //     buttonStyle.overlayColor?.resolve({MaterialState.disabled});
        // elevationTween.end =
        //     buttonStyle.elevation?.resolve({MaterialState.disabled});
        // shadowColorTween.end =
        //     buttonStyle.shadowColor?.resolve({MaterialState.disabled});
        // shapeBorderTween.end =
        //     buttonStyle.shape?.resolve({MaterialState.disabled});
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
        break;
      case ButtonState.loading:
        backgroundColorTween.end =
            loadingStyle?.style?.backgroundColor?.resolve({});
        foregroundColorTween.end =
            loadingStyle?.style?.foregroundColor?.resolve({});
        // overlayColorTween.end = loadingStyle?.style?.overlayColor?.resolve({});
        // elevationTween.end = loadingStyle?.style?.elevation?.resolve({});
        // shadowColorTween.end = loadingStyle?.style?.shadowColor?.resolve({});
        // shapeBorderTween.end = loadingStyle?.style?.shape?.resolve({});
        surfaceTintColorTween.end =
            loadingStyle?.style?.surfaceTintColor?.resolve({});

        // textStyleTween.end = loadingStyle?.style?.textStyle?.resolve({});
        edgeInsetsGeometryTween.end = loadingStyle?.style?.padding?.resolve({});
        alignmentGeometryTween.end = loadingStyle?.style?.alignment;
        // fixedSizeTween.end = loadingStyle?.style?.fixedSize?.resolve({});
        minimumSizeTween.end = loadingStyle?.style?.minimumSize?.resolve({});
        maximumSizeTween.end = loadingStyle?.style?.maximumSize?.resolve({});
        break;
      case ButtonState.success:
        backgroundColorTween.end =
            successStyle?.style?.backgroundColor?.resolve({});
        foregroundColorTween.end =
            successStyle?.style?.foregroundColor?.resolve({});
        // overlayColorTween.end = successStyle?.style?.overlayColor?.resolve({});
        // elevationTween.end = successStyle?.style?.elevation?.resolve({});
        // shadowColorTween.end = successStyle?.style?.shadowColor?.resolve({});
        // shapeBorderTween.end = successStyle?.style?.shape?.resolve({});
        surfaceTintColorTween.end =
            successStyle?.style?.surfaceTintColor?.resolve({});

        // textStyleTween.end = successStyle?.style?.textStyle?.resolve({});
        edgeInsetsGeometryTween.end = successStyle?.style?.padding?.resolve({});
        alignmentGeometryTween.end = successStyle?.style?.alignment;
        // fixedSizeTween.end = successStyle?.style?.fixedSize?.resolve({});
        minimumSizeTween.end = successStyle?.style?.minimumSize?.resolve({});
        maximumSizeTween.end = successStyle?.style?.maximumSize?.resolve({});
        break;
      case ButtonState.failure:
        backgroundColorTween.end =
            failureStyle?.style?.backgroundColor?.resolve({});
        foregroundColorTween.end =
            failureStyle?.style?.foregroundColor?.resolve({});
        // overlayColorTween.end = failureStyle?.style?.overlayColor?.resolve({});
        // elevationTween.end = failureStyle?.style?.elevation?.resolve({});
        // shadowColorTween.end = failureStyle?.style?.shadowColor?.resolve({});
        // shapeBorderTween.end = failureStyle?.style?.shape?.resolve({});
        surfaceTintColorTween.end =
            failureStyle?.style?.surfaceTintColor?.resolve({});

        // textStyleTween.end = failureStyle?.style?.textStyle?.resolve({});
        edgeInsetsGeometryTween.end = failureStyle?.style?.padding?.resolve({});
        alignmentGeometryTween.end = failureStyle?.style?.alignment;
        // fixedSizeTween.end = failureStyle?.style?.fixedSize?.resolve({});
        minimumSizeTween.end = failureStyle?.style?.minimumSize?.resolve({});
        maximumSizeTween.end = failureStyle?.style?.maximumSize?.resolve({});
        break;
      default:
        backgroundColorTween.end = buttonStyle.backgroundColor?.resolve({});
        foregroundColorTween.end = buttonStyle.foregroundColor?.resolve({});
        // overlayColorTween.end = buttonStyle.overlayColor?.resolve({});
        // elevationTween.end = buttonStyle.elevation?.resolve({});
        // shadowColorTween.end = buttonStyle.shadowColor?.resolve({});
        // shapeBorderTween.end = buttonStyle.shape?.resolve({});
        surfaceTintColorTween.end = buttonStyle.surfaceTintColor?.resolve({});

        // textStyleTween.end = buttonStyle.textStyle?.resolve({});
        edgeInsetsGeometryTween.end = buttonStyle.padding?.resolve({});
        alignmentGeometryTween.end = buttonStyle.alignment;
        // fixedSizeTween.end = buttonStyle.fixedSize?.resolve({});
        minimumSizeTween.end = buttonStyle.minimumSize?.resolve({});
        maximumSizeTween.end = buttonStyle.maximumSize?.resolve({});
    }

    backgroundColorTween.end ??= buttonStyle.backgroundColor?.resolve({});
    foregroundColorTween.end ??= buttonStyle.foregroundColor?.resolve({});
    // overlayColorTween.end ??= buttonStyle.overlayColor?.resolve({});
    // elevationTween.end ??= buttonStyle.elevation?.resolve({});
    // shadowColorTween.end ??= buttonStyle.shadowColor?.resolve({});
    // shapeBorderTween.end ??= buttonStyle.shape?.resolve({});
    surfaceTintColorTween.end ??= buttonStyle.surfaceTintColor?.resolve({});

    // textStyleTween.end ??= buttonStyle.textStyle?.resolve({});
    edgeInsetsGeometryTween.end ??= buttonStyle.padding?.resolve({});
    alignmentGeometryTween.end ??= buttonStyle.alignment;
    // fixedSizeTween.end ??= buttonStyle.fixedSize?.resolve({});
    minimumSizeTween.end ??= buttonStyle.minimumSize?.resolve({});
    maximumSizeTween.end ??= buttonStyle.maximumSize?.resolve({});

    animationController.forward(from: 0);
    postUpdateCallback(nextState);
  }
}
