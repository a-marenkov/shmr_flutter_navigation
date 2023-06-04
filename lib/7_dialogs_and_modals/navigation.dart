import 'package:flutter/material.dart';

import 'observer.dart';
import 'routes.dart';

class NavigationManager {
  NavigationManager._();

  static final instance = NavigationManager._();

  final key = GlobalKey<NavigatorState>();

  final observers = <NavigatorObserver>[
    NavigationLogger(),
  ];

  NavigatorState get _navigator => key.currentState!;

  Future<int?> openCounter(int? initialCount) {
    return _navigator.pushNamed<int?>(
      RouteNames.counter,
      arguments: initialCount,
    );
  }

  void maybePop<T extends Object>([T? result]) {
    _navigator.maybePop(result);
  }

  void pop<T extends Object>([T? result]) {
    _navigator.pop(result);
  }

  void popToHome() {
    _navigator.popUntil(ModalRoute.withName(RouteNames.home));
  }
}
