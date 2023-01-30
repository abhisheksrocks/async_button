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
