import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'navigation.dart';
import 'routes.dart';

class WillPopScopeDemoApp extends StatelessWidget {
  const WillPopScopeDemoApp({super.key});

  static const title = 'Will Pop Scope';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final didChangeCount = _counter != widget.initialCount;
        print('WillPopScope 1 didChangeCount = $didChangeCount');

        // if(didChangeCount) {
        //   NavigationManager.instance.pop(_counter);
        // }
        // return false;

        return didChangeCount;
      },
      child: WillPopScope(
        onWillPop: () async {
          print('WillPopScope 2 always true');
          return true;
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
      ),
    );
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
            'Page not found\n$routeName',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
