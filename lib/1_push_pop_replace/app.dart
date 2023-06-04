import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PushPopReplaceDemoApp extends StatelessWidget {
  const PushPopReplaceDemoApp({super.key});

  static const String title = 'Push, Pop & Replace';

  @override
  Widget build(BuildContext context) {
    const home = HomePage(title: title);

    if (defaultTargetPlatform.isCupertino) {
      return const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: CupertinoThemeData(
          primaryColor: Colors.blue,
        ),
        home: home,
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: home,
      );
    }
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isCupertino = Theme.of(context).platform.isCupertino;

    if (isCupertino) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(title),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Push the button see Counter:',
              ),
              CupertinoButton(
                onPressed: () {
                  _onOpenCounter(
                    context,
                    isCupertino: isCupertino,
                  );
                },
                child: const Text('Open Counter'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Push the button see Counter:',
              ),
              ElevatedButton(
                onPressed: () {
                  _onOpenCounter(
                    context,
                    isCupertino: isCupertino,
                  );
                },
                child: const Text('Open Counter'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _onOpenCounter(
    BuildContext context, {
    required bool isCupertino,
  }) {
    Navigator.push(
      context,
      isCupertino
          ? CupertinoPageRoute(
              builder: (BuildContext context) {
                return CounterPage(title: title);
              },
            )
          : MaterialPageRoute(
              builder: (BuildContext context) {
                return CounterPage(title: title);
              },
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
    final isCupertino = Theme.of(context).platform.isCupertino;

    if (isCupertino) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.title),
        ),
        child: Center(
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
              CupertinoButton(
                onPressed: _incrementCounter,
                child: const Icon(Icons.add),
              ),
              CupertinoButton(
                onPressed: _onGoBack,
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
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
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Icon(Icons.add),
              ),
              ElevatedButton(
                onPressed: _onGoBack,
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onGoBack() {
    Navigator.pop(context);
    // Navigator.of(context).pop();
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TargetPlatform platform = defaultTargetPlatform;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          platform.isCupertino
              ? CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return HomePage(title: widget.title);
                  },
                )
              : MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomePage(title: widget.title);
                  },
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;

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
