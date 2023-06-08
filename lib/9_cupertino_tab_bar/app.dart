import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation.dart';
import 'routes.dart';

class CupertinoTabBarDemoApp extends StatelessWidget {
  const CupertinoTabBarDemoApp({super.key});

  static const title = 'Cupertino Tab Bar';

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
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final _tabs = const [
    HomeContent(index: 0, key: ValueKey(0)),
    HomeContent(index: 1, key: ValueKey(1)),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoTabScaffold(
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            // navigatorKey: NavigationManager.tabs[index]?.key,
            // onGenerateRoute: RoutesBuilder.onGenerateRoute,
            // onUnknownRoute: RoutesBuilder.onUnknownRoute,
            // navigatorObservers: NavigationManager.tabs[index]?.observers ??
            //     const <NavigatorObserver>[],
            builder: (context) => CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text('${CupertinoTabBarDemoApp.title} ${_index + 1}'),
              ),
              child: _tabs[index],
            ),
          );
        },
        tabBar: CupertinoTabBar(
          currentIndex: _index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_one_outlined),
              label: 'First',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_two_outlined),
              label: 'Second',
            ),
          ],
          onTap: (index) {
            if (_index != index) {
              setState(() {
                _index = index;
              });
            }
          },
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({required this.index, super.key});

  final int index;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int? _lastCount;

  @override
  void dispose() {
    print('$HomeContent at index ${widget.index} is disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Counter No ${widget.index + 1}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
          CupertinoButton(
            onPressed: _onOpenCounter,
            child: const Text('Open Counter'),
          ),
        ],
      ),
    );
  }

  Future<void> _onOpenCounter() async {
    final args = CounterPageArgs(
      index: widget.index,
      initialCount: _lastCount,
    );

    final result = await Navigator.of(context).push<int?>(
      MaterialPageRoute(
        builder: (context) => CounterPage(
          title: CupertinoTabBarDemoApp.title,
          index: widget.index,
          initialCount: _lastCount,
        ),
        settings: RouteSettings(
          name: RouteNames.counter,
          arguments: args,
        ),
      ),
    );
    // final result = await NavigationManager.tabs[widget.index]?.openCounter(args);
    // final result = await NavigationManager.instance.openCounter(args);
    setState(() {
      _lastCount = result;
    });
  }
}

class CounterPageArgs {
  final int index;
  final int? initialCount;

  CounterPageArgs({
    required this.index,
    required this.initialCount,
  });
}

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
    required this.title,
    required this.index,
    required this.initialCount,
  });

  final String title;
  final int index;
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
    Navigator.of(context).maybePop(_counter);
  }

  void _pop() {
    if (mounted) {
      Navigator.of(context).pop(_counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _pop();
        return false;
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Tab ${widget.index + 1}',
          middle: Text('Counter ${widget.index + 1}'),
        ),
        child: Material(
          type: MaterialType.transparency,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CupertinoButton(
                      onPressed: _decrementCounter,
                      child: const Icon(Icons.remove),
                    ),
                    CupertinoButton(
                      onPressed: _incrementCounter,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                CupertinoButton(
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
