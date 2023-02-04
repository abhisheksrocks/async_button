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

## **AsyncElevatedBtn**

Just like ElevatedButton, but for async onPressed

```dart
AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

AsyncElevatedBtn(
  asyncBtnStatesController: btnStateController,
  onPressed: () async {
    btnStateController.update(AsyncBtnState.loading);
    try {
      // Await your api call here
      await Future.delayed(const Duration(seconds: 2));
      btnStateController.update(AsyncBtnState.success);
    } catch (e) {
      btnStateController.update(AsyncBtnState.failure);
    }
  },
  // * It is NOT mandatory to define [loadingStyle, successStyle, failureStyle]
  // * if you don't need it.

  // This should ideally be the button's loading state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  loadingStyle: AsyncBtnStateStyle(
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
  successStyle: AsyncBtnStateStyle(
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
  failureStyle: AsyncBtnStateStyle(
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
AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

AsyncElevatedBtn.withDefaultStyles(
  asyncBtnStatesController: btnStateController,
  onPressed: () async {
    btnStateController.update(AsyncBtnState.loading);
    try {
      // Await your api call here
      await Future.delayed(const Duration(seconds: 2));
      btnStateController.update(AsyncBtnState.success);
    } catch (e) {
      btnStateController.update(AsyncBtnState.failure);
    }
  },
  child: const Text('Execute'),
);
```

## **AsyncTextBtn**

And this is our version of async TextButton

```dart
AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

AsyncTextBtn(
  asyncBtnStatesController: btnStateController,
  onPressed: () async {
    btnStateController.update(AsyncBtnState.loading);
    try {
      // Await your api call here
      await Future.delayed(const Duration(seconds: 2));
      btnStateController.update(AsyncBtnState.success);
    } catch (e) {
      btnStateController.update(AsyncBtnState.failure);
    }
  },
  // * It is NOT mandatory to define [loadingStyle, successStyle, failureStyle]
  // * if you don't need it.

  // This should ideally be the button's loading state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  loadingStyle: AsyncBtnStateStyle(
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
  successStyle: AsyncBtnStateStyle(
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
  failureStyle: AsyncBtnStateStyle(
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
AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

AsyncTextBtn.withDefaultStyles(
  asyncBtnStatesController: btnStateController,
  onPressed: () async {
    btnStateController.update(AsyncBtnState.loading);
    try {
      // Await your api call here
      await Future.delayed(const Duration(seconds: 2));
      btnStateController.update(AsyncBtnState.success);
    } catch (e) {
      btnStateController.update(AsyncBtnState.failure);
    }
  },
  child: const Text('Execute'),
);
```

## **AsyncOutlinedBtn**

Similarly, here's one for async OutlinedButton

```dart
AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

AsyncOutlinedBtn(
  asyncBtnStatesController: btnStateController,
  onPressed: () async {
    btnStateController.update(AsyncBtnState.loading);
    try {
      // Await your api call here
      await Future.delayed(const Duration(seconds: 2));
      btnStateController.update(AsyncBtnState.success);
    } catch (e) {
      btnStateController.update(AsyncBtnState.failure);
    }
  },
  // * It is NOT mandatory to define [loadingStyle, successStyle, failureStyle]
  // * if you don't need it.

  // This should ideally be the button's loading state indicator.
  // If [style] or [widget] properties are not defined, we consider the button's
  // corresponding default [style] and [child] property
  loadingStyle: AsyncBtnStateStyle(
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
  successStyle: AsyncBtnStateStyle(
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
  failureStyle: AsyncBtnStateStyle(
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
AsyncBtnStatesController btnStateController = AsyncBtnStatesController();

AsyncOutlinedBtn.withDefaultStyles(
  asyncBtnStatesController: btnStateController,
  onPressed: () async {
    btnStateController.update(AsyncBtnState.loading);
    try {
      // Await your api call here
      await Future.delayed(const Duration(seconds: 2));
      btnStateController.update(AsyncBtnState.success);
    } catch (e) {
      btnStateController.update(AsyncBtnState.failure);
    }
  },
  child: const Text('Execute'),
);
```

# More Intuitive Examples

All buttons also supports these arguments - `styleBuilder`, `loadingStyleBuilder`, `successStyleBuilder` and `failureStyleBuilder` which creates the custom state styles at runtime. This essentially mean that one can create unlimited number of custom state widgets and styles based on different conditions.

There are also scopes for fallback styles and widgets if none of the necessary conditions are met.

## Login Button

<a href="https://github.com/abhisheksrocks/async_button/wiki/Intuitive-Example:-Login-Button">
  <img src='https://github.com/abhisheksrocks/async_button/blob/main/doc/gif/example_login_btn.gif?raw=true' width=100%>
</a>

[Click here for Code!](https://github.com/abhisheksrocks/async_button/wiki/Intuitive-Example:-Login-Button)

## Download Button

<a href="https://github.com/abhisheksrocks/async_button/wiki/Intuitive-Example:-Download-Button">
  <img src='https://github.com/abhisheksrocks/async_button/blob/main/doc/gif/example_download_btn.gif?raw=true' width=100%>
</a>

[Click here for Code!](https://github.com/abhisheksrocks/async_button/wiki/Intuitive-Example:-Download-Button)

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
