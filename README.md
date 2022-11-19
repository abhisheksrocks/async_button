<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

![Async Button](https://github.com/abhisheksrocks/async_button/blob/main/doc/image/hero.png?raw=true)

Buttons get boring when there is an asynchronous onTap function involved. Users don't get to see if or when the onTap function has finished execution, or if it has even finished sucessfully. To put it simply, this project aims to make them a little un-boring.

# What is this?

This project provides you with the same buttons that you are used to, just with some modifications under the hood. You can manipulate the button state based on whether the onTap function is idle, loading or has finished loading(successfully or unsuccessfully).

<img src='https://github.com/abhisheksrocks/async_button/blob/main/doc/gif/sample.gif?raw=true' width=100%>

# How to use it?

This project provides you with 3 types of buttons. Let's list them below with an example.

## **AsyncElevatedButton**

Just like ElevatedButton, but for async onPressed

```dart
AsyncElevatedButton(
  onPressed: (AsyncButtonStateController btnStateController) async {
    btnStateController.update(ButtonState.loading);
    try {
      // Await your api call here
      btnStateController.update(ButtonState.success);
    } catch (e) {
      btnStateController.update(ButtonState.failure);
    }
  },
  // * It is NOT mandatory to define [loadingStyle, successStyle, failureStyle]
  // * if you don't need it.

  // This should ideally be the button's loading state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  loadingStyle: AsyncButtonStateStyle(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.amber,
    ),
    widget: const SizedBox.square(
      dimension: 24,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  ),

  // This should ideally be the button's success state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  successStyle: AsyncButtonStateStyle(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
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

  // This should ideally be the button's failure state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  failureStyle: AsyncButtonStateStyle(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
    widget: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.error),
        SizedBox(width: 4),
        Text('Error!'),
      ],
    ),
  ),
  child: const Text('Execute'),
);
```

Too much? We have created a custom constructor that uses the exact values for `loadingStyle`, `successStyle` and `failureStyle` as above

```dart
AsyncElevatedButton.withDefaultStyles(
  onPressed: (AsyncButtonStateController btnStateController) async {
    btnStateController.update(ButtonState.loading);
    try {
      // Await your api call here
      btnStateController.update(ButtonState.success);
    } catch (e) {
      btnStateController.update(ButtonState.failure);
    }
  },
  child: const Text('Execute'),
);
```

## **AsyncTextButton**

And this is our version of async TextButton

```dart
AsyncTextButton(
  onPressed: (AsyncButtonStateController btnStateController) async {
    btnStateController.update(ButtonState.loading);
    try {
      // Await your api call here
      btnStateController.update(ButtonState.success);
    } catch (e) {
      btnStateController.update(ButtonState.failure);
    }
  },
  // * It is NOT mandatory to define [loadingStyle, successStyle, failureStyle]
  // * if you don't need it.

  // This should ideally be the button's loading state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  loadingStyle: AsyncButtonStateStyle(
    style: TextButton.styleFrom(
      foregroundColor: Colors.amber,
    ),
    widget: const SizedBox.square(
      dimension: 24,
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    ),
  ),


  // This should ideally be the button's success state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  successStyle: AsyncButtonStateStyle(
    style: TextButton.styleFrom(
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

  // This should ideally be the button's failure state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  failureStyle: AsyncButtonStateStyle(
    style: TextButton.styleFrom(
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
  child: const Text('Execute'),
);
```

Here again, you can use the following constructor instead

```dart
AsyncTextButton.withDefaultStyles(
  onPressed: (AsyncButtonStateController btnStateController) async {
    btnStateController.update(ButtonState.loading);
    try {
      // Await your api call here
      btnStateController.update(ButtonState.success);
    } catch (e) {
      btnStateController.update(ButtonState.failure);
    }
  },
  child: const Text('Execute'),
);
```

## **AsyncOutlinedButton**

Similarly, here's one for async OutlinedButton

```dart
AsyncOutlinedButton(
  onPressed: (AsyncButtonStateController btnStateController) async {
    btnStateController.update(ButtonState.loading);
    try {
      // Await your api call here
      btnStateController.update(ButtonState.success);
    } catch (e) {
      btnStateController.update(ButtonState.failure);
    }
  },
  // * It is NOT mandatory to define [loadingStyle, successStyle, failureStyle]
  // * if you don't need it.

  // This should ideally be the button's loading state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  loadingStyle: AsyncButtonStateStyle(
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

  // This should ideally be the button's success state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  successStyle: AsyncButtonStateStyle(
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

  // This should ideally be the button's failure state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  failureStyle: AsyncButtonStateStyle(
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
  child: const Text('Execute'),
);
```

Here as well, there is an alternative constructor

```dart
AsyncOutlinedButton.withDefaultStyles(
  onPressed: (AsyncButtonStateController btnStateController) async {
    btnStateController.update(ButtonState.loading);
    try {
      // Await your api call here
      btnStateController.update(ButtonState.success);
    } catch (e) {
      btnStateController.update(ButtonState.failure);
    }
  },
  child: const Text('Execute'),
);
```

# More Intuitive Examples

All buttons also supports these arguments - `loadingStyleBuilder`, `successStyleBuilder` and `failureStyleBuilder` which creates the custom state styles at runtime. This essentially mean that one can create unlimited number of custom state widgets and styles based on different conditions.

There are also scopes for fallback styles and widgets if none of the necessary conditions are met.

## Login Button

<img src='https://github.com/abhisheksrocks/async_button/blob/main/doc/gif/login_sample.gif?raw=true' width=100%>

In the above example:

- There is **1** loading style - 'Signing In...'
- There are **2** failure styles - 'Network Error', 'Wrong Password'
- There is **1** success style - 'Welcome, \<CustomName\>!' (Note that 'Abhishek' is provided at runtime)

Lets see how to create something like this. We'll also use fallback styles and widgets.

```dart
AsyncOutlinedButton(
  onPressed: (btnStateController) async {
    btnStateController.update(ButtonState.loading);
    try {
      // Call your API here, in this example we are simply waiting
      // for 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      // To simulate randomness, we are making use of dart provided
      // [Random] class.
      // In the real world, these exception are of course thrown as per
      // different conditions
      int randomValue = Random().nextInt(5);
      if (randomValue == 0) {
        throw CustomNetworkException('Network Error');
      }
      if (randomValue == 1) {
        throw CustomLoginException('Wrong Password');
      }
      if (randomValue == 2) {
        // The following will invoke the default/fallback [failureStyle] as
        // this case is not handled in [failureStyleBuilder]
        throw Exception('Unhandled exception');
      }
      if (randomValue == 3) {
        // If we are using [successStyleBuilder], all the
        // [btnStateController.update(ButtonState.success)] calls will
        // eventually invoke it.
        // Otherwise, it will simply use [successStyle] data.
        btnStateController.update(ButtonState.success, data: 'Abhishek');
      }
      // The following will invoke the default/fallback [successStyle] as
      // this case is not handled in [successStyleBuilder]
      btnStateController.update(ButtonState.success);
    } on CustomNetworkException catch (e) {
      // Handle this [CustomNetworkException] exception
      //
      // If we are using [failureStyleBuilder], all the
      // [btnStateController.update(ButtonState.failure)] calls will
      // eventually invoke it.
      // Otherwise, it will simply use [failureStyle] data.
      btnStateController.update(
        ButtonState.failure,
        data: e,
      );
    } on CustomLoginException catch (e) {
      // Handle this [CustomLoginException] exception
      //
      // If we are using [failureStyleBuilder], all the
      // [btnStateController.update(ButtonState.failure)] calls will
      // eventually invoke it.
      // Otherwise, it will simply use [failureStyle] data.
      btnStateController.update(
        ButtonState.failure,
        data: e,
      );
    } catch (e) {
      // Handle exception
      //
      // If we are using [failureStyleBuilder], all the
      // [btnStateController.update(ButtonState.failure)] calls will
      // eventually invoke it.
      // Otherwise, it will simply use [failureStyle] data.
      btnStateController.update(
        ButtonState.failure,
        data: e,
      );
    }
  },

  // Since for the given example, we don't need a runtime loading style,
  // we make use of the [loadingStyle] property.
  loadingStyle: AsyncButtonStateStyle(
    style: OutlinedButton.styleFrom(
      backgroundColor: const Color(0xFFC4D8F6),
      foregroundColor: const Color(0xFF006bff),
    ),
    widget: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Color(0xFF006bff),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text('Signing in...'),
      ],
    ),
  ),

  // It's a good measure to use [failureStyle]. This also acts as a fallback
  // failure style if [failureStyleBuilder]'s returned value is null.

  // If this value is null, we fallback to button's [child] value.
  failureStyle: AsyncButtonStateStyle(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFFFF3B30),
    ),
    widget: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.error,
        ),
        SizedBox(
          width: 4,
        ),
        Text('Error Occurred!'),
      ],
    ),
  ),

  // This function is executed at runtime, and can also return null, in
  // which case [failureStyle] value will be used.
  failureStyleBuilder: (data) {
    // Any onPressed's [btnStateController.update(ButtonState.failure)]
    // eventually invokes this builder function.

    if (data is CustomNetworkException) {
      return AsyncButtonStateStyle(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.amber,
        ),
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.signal_cellular_connected_no_internet_0_bar,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(data.message),
          ],
        ),
      );
    }
    if (data is CustomLoginException) {
      return AsyncButtonStateStyle(
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(data.message),
          ],
        ),
      );
    }
    // For any unhandled [data] value we can return null.
    return null;
  },

  // It's a good measure to use [successStyle]. This also acts as a fallback
  // failure style if [successStyleBuilder]'s returned value is null.

  // If this value is null, we fallback to button's [child] value.
  successStyle: AsyncButtonStateStyle(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.green,
    ),
    widget: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text('Logged In!'),
      ],
    ),
  ),

  // This function is executed at runtime, and can also return null, in
  // which case [successStyle] value will be used.
  successStyleBuilder: (data) {
    if (data is String) {
      return AsyncButtonStateStyle(
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome, $data!'),
          ],
        ),
      );
    }

    // For any unhandled [data] value we can return null.
    return null;
  },
  style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.all(16),
    backgroundColor: const Color(0xFF006bff),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
      side: BorderSide.none,
    ),
    textStyle: const TextStyle(
      fontSize: 20,
    ),
  ),
  child: const Text('Login'),
);

// For this example we created the following 2 custom exceptions
// In a real-world project one may encounter different exceptions

class CustomNetworkException implements Exception {
  final String message;

  CustomNetworkException(this.message);
}

class CustomLoginException implements Exception {
  final String message;

  CustomLoginException(this.message);
}

```

# Similar Projects

If this library doesn't cater to your requirements. Here are the some similar projects you can explore:

- <div style="display:flex;">
    <p>async_button_builder</p>
    <a href="https://github.com/Nolence/async_button_builder" style="margin-left: 8px">
      <img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/github_icon.svg?raw=true" width=20px/>
    </a>
    <a href="https://pub.dev/packages/async_button_builder" style="margin-left: 8px">
      <img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/pubdev_icon.svg?raw=true" width=20px/>
    </a>
  </div>
- <div style="display:flex;">
    <p>easy_loading_button</p>
    <a href="https://github.com/usefulteam/easy_loading_button" style="margin-left: 8px">
      <img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/github_icon.svg?raw=true" width=20px/>
    </a>
    <a href="https://pub.dev/packages/easy_loading_button" style="margin-left: 8px">
      <img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/pubdev_icon.svg?raw=true" width=20px/>
    </a>
  </div>
- <div style="display:flex;">
    <p>animated_loading_button</p>
    <a href="https://github.com/koukibadr/Animated_Loading_Button" style="margin-left: 8px">
      <img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/github_icon.svg?raw=true" width=20px/>
    </a>
    <a href="https://pub.dev/packages/animated_loading_button" style="margin-left: 8px">
      <img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/pubdev_icon.svg?raw=true" width=20px/>
    </a>
  </div>

# Contribute

The creator always appreciates a helping hand, so don't hesitate before creating a pull request or reporting a bug/issue.

# Connect with the Creator

The creator does aspire to help grow the flutter community. So if you have a question related to this project, your project, or anything flutter, connect with him over the following links. Don't worry, it's free!😉

<div style="display: flex;">
  <a href="https://www.linkedin.com/in/abhishek-97099b125/" ><img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/linkedin_icon.svg?raw=true" width=20px/></a>
  <a href="https://www.linkedin.com/in/abhishek-97099b125/" style="margin-left: 8px">LinkedIn</a>
</div>
<div style="display: flex;">
  <a href="mailto:abhishekbinay@gmail.com" ><img src = "https://github.com/abhisheksrocks/async_button/blob/main/doc/image/icon/email_icon.svg?raw=true" width=20px/></a>
  <a href="mailto:abhishekbinay@gmail.com" style="margin-left: 8px">abhishekbinay@gmail.com</a>
</div>
<br/>
Made with ❤️
