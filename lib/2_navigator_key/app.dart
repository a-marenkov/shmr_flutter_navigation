import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'navigation.dart';

class NavigatorKeyDemoApp extends StatelessWidget {
  const NavigatorKeyDemoApp({super.key});

  static const String title = 'Navigator Key';

  @override
  Widget build(BuildContext context) {
    const home = WelcomePage(title: title);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
      // navigator key
      navigatorKey: NavigationManager.instance.key,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

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

  void _onOpenCounter() {
    NavigationManager.instance.openCounter(title);
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

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => NavigationManager.instance.openHome(widget.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Welcome to ${widget.title}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
