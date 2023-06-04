import 'dart:async';

import 'package:flutter/material.dart';

import 'dialogs.dart';
import 'navigation.dart';
import 'routes.dart';

class TabBarDemoApp extends StatelessWidget {
  const TabBarDemoApp({super.key});

  static const title = 'Tab Bar';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('${TabBarDemoApp.title} ${_index + 1}'),
      ),
      body: _tabs[_index],
      // body: IndexedStack(
      //   index: _index,
      //   children: _tabs,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
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

  Future<void> _onOpenCounter() async {
    final result = await NavigationManager.instance.openCounter(_lastCount);
    setState(() {
      _lastCount = result;
    });
  }

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
          ElevatedButton(
            onPressed: _onOpenCounter,
            child: const Text('Open Counter'),
          ),
        ],
      ),
    );
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
          final confirmed = await Dialogs.showConfirmCloseCountModal(context);
          willPop = confirmed ?? false;
        }

        if (willPop) {
          NavigationManager.instance.pop(_counter);
        }

        return false;
      },
      child: Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              ElevatedButton(
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
