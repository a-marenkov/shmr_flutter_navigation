import 'package:flutter/material.dart';

import 'app.dart';
import 'observer.dart';
import 'routes.dart';

class NavigationManager {
  final String tag;
  
  NavigationManager._(this.tag);

  static final instance = NavigationManager._('root');
  static final tabs = Map<int, NavigationManager>.unmodifiable({
    0: NavigationManager._('tab_1'),
    1: NavigationManager._('tab_2'),
  });

  final key = GlobalKey<NavigatorState>();

  late final observers = <NavigatorObserver>[
    NavigationLogger(tag),
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
