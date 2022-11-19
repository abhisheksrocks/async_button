import 'async_button_state_controller_abstract.dart';

// Why can't we make [AsyncButtonStateController] a simple class(instead of
// being abstract)?
// Because, I can't see the users of this package ever creating an instance
// of that class for themselves.
// If ever there is need for it, a user can implement/extend the class,
// and use it for there purpose.

/// Used to control button's state changes animation
///
/// Used by [AsyncButtonCore]
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
