import 'package:flutter/material.dart';

import '../helpers/constants.dart';

/// Model associated with [AsyncBtnStatesController]
class AsyncBtnStateModel {
  /// Defines the [AsyncBtnState] associated with current async button state
  final AsyncBtnState buttonState;

  /// Defines the data associated with current async button state
  final dynamic data;

  /// Creates a [AsyncBtnStateModel]
  const AsyncBtnStateModel(
    this.buttonState, {
    this.data,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AsyncBtnStateModel && other.buttonState == buttonState;
  }

  @override
  int get hashCode => buttonState.hashCode ^ data.hashCode;
}

/// Used to control button's state changes animation
class AsyncBtnStatesController extends ValueNotifier<AsyncBtnStateModel?> {
  /// Creates a [AsyncBtnStatesController]
  /// Providing [data] alone will have no effect.
  AsyncBtnStatesController({
    AsyncBtnState? defaultButtonState,
    dynamic data,
  }) : super(
          defaultButtonState == null
              ? null
              : AsyncBtnStateModel(defaultButtonState, data: data),
        );

  /// Updates the button's current [buttonState] to next
  /// [data] is relevant, if you are using builder styles
  void update(
    AsyncBtnState buttonState, {
    dynamic data,
  }) {
    value = AsyncBtnStateModel(buttonState, data: data);
    notifyListeners();
  }
}
