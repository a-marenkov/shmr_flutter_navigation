import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'navigation.dart';
import 'routes.dart';

class NamedRoutesDemoApp extends StatelessWidget {
  const NamedRoutesDemoApp({super.key});

  static const title = 'Named Routes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Colors.blue,
        ),
      ),
      // navigator key
      navigatorKey: NavigationManager.instance.key,
      // named routes setup
      initialRoute: RouteNames.initialRoute,
      routes: RoutesBuilder.routes,
      // onGenerateRoute: RoutesBuilder.onGenerateRoute,
      // onUnknownRoute: RoutesBuilder.onUnknownRoute,
      // onGenerateInitialRoutes: RoutesBuilder.onGenerateInitialRoutes,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  void _onOpenCounter() {
    NavigationManager.instance.openCounter();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text(title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

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
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            MyButton(
              onPressed: _incrementCounter,
              child: const Icon(Icons.add),
            ),
            MyButton(
              onPressed: _onGoBack,
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onGoBack() {
    NavigationManager.instance.pop();
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
