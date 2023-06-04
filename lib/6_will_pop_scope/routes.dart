import 'package:flutter/material.dart';

import 'app.dart';

abstract class RouteNames {
  const RouteNames._();

  static const initialRoute = home;

  static const home = '/';
  static const counter = '/counter';
}

abstract class RoutesBuilder {
  const RoutesBuilder._();

  static Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(
            title: WillPopScopeDemoApp.title,
          ),
          settings: settings,
        );

      case RouteNames.counter:
        return MaterialPageRoute<int?>(
          builder: (_) => CounterPage(
            title: WillPopScopeDemoApp.title,
            initialCount: settings.arguments as int?,
          ),
          settings: settings,
        );
    }

    return null;
  }

  static Route<Object?>? onUnknownRoute<T>(RouteSettings settings) {
    return MaterialPageRoute<T>(
      builder: (context) => UnknownPage(
        routeName: settings.name,
      ),
      settings: settings,
    );
  }

  static List<Route<Object?>> onGenerateInitialRoutes(String initialRoutes) {
    final routes = <Route>[];

    if (initialRoutes.isEmpty || !initialRoutes.startsWith('/')) {
      print('invalid initialRoutes ($initialRoutes)');
    } else {
      final names = initialRoutes.substring(1).split('/');
      for (final name in names) {
        final route = onGenerateRoute(
          RouteSettings(name: '/$name'),
        );
        if (route != null) {
          routes.add(route);
        } else {
          routes.clear();
          break;
        }
      }
    }

    if (routes.isEmpty) {
      print('generated empty initial routes ($initialRoutes)');
      routes.add(
        onGenerateRoute(const RouteSettings(name: RouteNames.home))!,
      );
    }

    return routes;
  }
}
