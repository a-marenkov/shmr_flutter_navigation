import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'dialogs.dart';
import 'navigation.dart';
import 'routes.dart';

class DialogsAndModalsDemoApp extends StatelessWidget {
  const DialogsAndModalsDemoApp({super.key});

  static const title = 'Dialogs & Modals';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // navigator key
      navigatorKey: NavigationManager.instance.key,
      // named routes setup
      initialRoute: RouteNames.initialRoute,
      onGenerateRoute: RoutesBuilder.onGenerateRoute,
      onUnknownRoute: RoutesBuilder.onUnknownRoute,
      onGenerateInitialRoutes: RoutesBuilder.onGenerateInitialRoutes,
      // navigator observers
      navigatorObservers: NavigationManager.instance.observers,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _lastCount;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text(widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_lastCount',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'Push the button see Counter:',
            ),
            MyButton(
              onPressed: _onOpenCounter,
              child: const Text('Open Counter'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpenCounter() async {
    final result = await NavigationManager.instance.openCounter(_lastCount);
    setState(() {
      _lastCount = result;
    });
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
    required this.title,
    required this.initialCount,
  });

  final String title;
  final int? initialCount;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCount ?? 0;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _onGoBack() {
    NavigationManager.instance.maybePop(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var willPop = true;

        if (_counter == widget.initialCount) {
          final confirmed = await Dialogs.showConfirmCloseCountDialog(context);
          willPop = confirmed ?? false;
        }

        if (willPop) {
          NavigationManager.instance.pop(_counter);
        }

        return false;
      },
      child: MyScaffold(
        title: Text(widget.title),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    onPressed: _decrementCounter,
                    child: const Icon(Icons.remove),
                  ),
                  MyButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              MyButton(
                onPressed: _onGoBack,
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({
    required this.routeName,
    super.key,
  });

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Page not found ($routeName)',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
