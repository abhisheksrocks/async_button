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

  AsyncBtnStatesController elevatedBtnController = AsyncBtnStatesController();
  AsyncBtnStatesController outlinedBtnController = AsyncBtnStatesController();
  AsyncBtnStatesController textBtnController = AsyncBtnStatesController();

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
            AsyncElevatedBtn.withDefaultStyles(
              asyncBtnStatesController: elevatedBtnController,
              onPressed: () async {
                try {
                  elevatedBtnController.update(AsyncBtnState.loading);

                  // await for your API/async process here, in this example we are
                  // simply waiting for 2 seconds
                  await Future.delayed(const Duration(seconds: 2));
                  if (!toFinishSuccessfully) throw '';
                  elevatedBtnController.update(AsyncBtnState.success);
                } catch (e) {
                  elevatedBtnController.update(AsyncBtnState.failure);
                }
              },
              child: const Text('Execute'),
            ),
            AsyncTextBtn.withDefaultStyles(
              asyncBtnStatesController: textBtnController,
              onPressed: () async {
                try {
                  textBtnController.update(AsyncBtnState.loading);

                  // await for your API/async process here, in this example we are
                  // simply waiting for 2 seconds
                  await Future.delayed(const Duration(seconds: 2));
                  if (!toFinishSuccessfully) throw '';
                  textBtnController.update(AsyncBtnState.success);
                } catch (e) {
                  textBtnController.update(AsyncBtnState.failure);
                }
              },
              child: const Text('Execute'),
            ),
            AsyncOutlinedBtn.withDefaultStyles(
              asyncBtnStatesController: outlinedBtnController,
              onPressed: () async {
                try {
                  outlinedBtnController.update(AsyncBtnState.loading);

                  // await for your API/async process here, in this example we are
                  // simply waiting for 2 seconds
                  await Future.delayed(const Duration(seconds: 2));
                  if (!toFinishSuccessfully) throw '';
                  outlinedBtnController.update(AsyncBtnState.success);
                } catch (e) {
                  outlinedBtnController.update(AsyncBtnState.failure);
                }
                toFinishSuccessfully = !toFinishSuccessfully;
              },
              child: const Text('Execute'),
            ),
          ],
        ),
      ),
    );
  }
}
