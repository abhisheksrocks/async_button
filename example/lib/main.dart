import 'package:async_button/async_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toFinishSuccessfully = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('async_button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: AsyncElevatedButton.withDefaultStyles(
                onPressed:
                    (AsyncButtonStateController btnStateController) async {
                  try {
                    btnStateController.update(ButtonState.loading);

                    // await for your API/async process here, in this example we are
                    // simply waiting for 2 seconds
                    await Future.delayed(const Duration(seconds: 2));

                    btnStateController.update(ButtonState.success);
                  } catch (e) {
                    btnStateController.update(ButtonState.failure);
                  }
                },
                child: const Text('Execute'),
              ),
            ),
            AsyncTextButton.withDefaultStyles(
              onPressed: (AsyncButtonStateController btnStateController) async {
                try {
                  btnStateController.update(ButtonState.loading);

                  // await for your API/async process here, in this example we are
                  // simply waiting for 2 seconds
                  await Future.delayed(const Duration(seconds: 2));

                  btnStateController.update(ButtonState.success);
                } catch (e) {
                  btnStateController.update(ButtonState.failure);
                }
              },
              child: const Text('Execute'),
            ),
            AsyncOutlinedButton.withDefaultStyles(
              onPressed: (AsyncButtonStateController btnStateController) async {
                try {
                  btnStateController.update(ButtonState.loading);

                  // await for your API/async process here, in this example we are
                  // simply waiting for 2 seconds
                  await Future.delayed(const Duration(seconds: 2));

                  btnStateController.update(ButtonState.success);
                } catch (e) {
                  btnStateController.update(ButtonState.failure);
                }
              },
              child: const Text('Execute'),
            ),
          ],
        ),
      ),
    );
  }
}
