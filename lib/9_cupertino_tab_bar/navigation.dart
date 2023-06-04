import 'package:flutter/material.dart';

import 'app.dart';
import 'observer.dart';
import 'routes.dart';

class NavigationManager {
  NavigationManager._();

  static final root = NavigationManager._();
  static final tabs = Map<int, NavigationManager>.unmodifiable({
    0: NavigationManager._(),
    1: NavigationManager._(),
  });

  final key = GlobalKey<NavigatorState>();

  final observers = <NavigatorObserver>[
    NavigationLogger(),
  ];

  NavigatorState get _navigator => key.currentState!;

  Future<int?> openCounter(CounterPageArgs args) {
    return _navigator.pushNamed<int?>(
      RouteNames.counter,
      arguments: args,
    );
  }

  void maybePop<T extends Object>([T? result]) {
    _navigator.maybePop(result);
  }

  void pop<T extends Object>([T? result]) {
    _navigator.pop(result);
  }

  void popToHome() {
    _navigator.popUntil((route) => route.settings.name == RouteNames.home);
  }
}
