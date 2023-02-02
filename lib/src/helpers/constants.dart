/// Corresponds to different button's state
@Deprecated(
  'This feature was deprecated after v1.0.1-beta.2',
)
enum ButtonState {
  /// When a button onPressed/onTap is null
  disabled,

  /// The most natural button's state
  idle,

  /// To be used when button's onPressed is currently being executed
  loading,

  /// If the button's onPressed finished successfully
  success,

  /// If the button's onPressed finished un-successfully
  failure,
}

/// Corresponds to different button's state
enum AsyncBtnState {
  /// The most natural button's state
  idle,

  /// To be used when button's onPressed is currently being executed
  loading,

  /// If the button's onPressed finished successfully
  success,

  /// If the button's onPressed finished un-successfully
  failure,
}
