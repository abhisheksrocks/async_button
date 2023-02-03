import 'async_button_state_controller_abstract.dart';

/// Used to control button's state changes animation
///
/// Used by [AsyncButtonCore]
@Deprecated(
  'This feature was deprecated after v1.0.1-beta.2',
)
class MainAsyncButtonStateController extends AsyncButtonStateController {
  /// Creates a [MainAsyncButtonStateController]
  MainAsyncButtonStateController({
    required super.animationController,

    //
    required super.backgroundColorAnimation,
    required super.foregroundColorAnimation,
    required super.overlayColorAnimation,
    required super.elevationAnimation,
    required super.shadowColorAnimation,
    required super.shapeBorderAnimation,
    required super.surfaceTintColorAnimation,
    required super.edgeInsetsGeometryAnimation,
    required super.alignmentGeometryAnimation,
    required super.minimumSizeAnimation,
    required super.maximumSizeAnimation,
    required super.borderSideAnimation,

    //
    required super.backgroundColorTween,
    required super.foregroundColorTween,
    required super.overlayColorTween,
    required super.elevationTween,
    required super.shadowColorTween,
    required super.shapeBorderTween,
    required super.surfaceTintColorTween,
    required super.edgeInsetsGeometryTween,
    required super.alignmentGeometryTween,
    required super.minimumSizeTween,
    required super.maximumSizeTween,
    required super.borderSideTween,

    //
    required super.buttonStyle,
    required super.loadingStyle,
    required super.loadingStyleBuilder,
    required super.successStyle,
    required super.successStyleBuilder,
    required super.failureStyle,
    required super.failureStyleBuilder,

    //
    required super.postUpdateCallback,
    required super.mountedFinder,
  });
}
