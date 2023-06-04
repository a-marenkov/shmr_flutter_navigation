import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'navigation.dart';
import 'routes.dart';

class NavigatorObserversDemoApp extends StatelessWidget {
  const NavigatorObserversDemoApp({super.key});

  static const title = 'Navigator Observers';

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

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void initState() {
    super.initState();
    print('did init $HomePage');
  }

  @override
  void dispose() {
    print('did dispose $HomePage');
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   NavigationManager.instance.routeAwareObserver.subscribe(
  //     this,
  //     ModalRoute.of(context)!,
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   NavigationManager.instance.routeAwareObserver.unsubscribe(this);
  //   super.dispose();
  // }
  //
  // @override
  // void didPush() => print('$HomePage.didPush');
  //
  // @override
  // void didPushNext() => print('$HomePage.didPushNext');
  //
  // @override
  // void didPopNext() => print('$HomePage.didPopNext');
  //
  // @override
  // void didPop() => print('$HomePage.didPop');

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: Text(widget.title),
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

  void _onOpenCounter() async {
    NavigationManager.instance.openCounter();
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
