import 'package:flutter/material.dart';

import 'observer.dart';
import 'routes.dart';

class NavigationManager {
  NavigationManager._();

  static final instance = NavigationManager._();

  final key = GlobalKey<NavigatorState>();

  // final routeAwareObserver = RouteObserver();

  late final observers = <NavigatorObserver>[
    NavigationLogger(),
    // routeAwareObserver,
  ];

  NavigatorState get _navigator => key.currentState!;

  void openCounter() {
    _navigator.pushNamed(RouteNames.counter);
  }

  void pop() {
    _navigator.pop();
  }

  void popToHome() {
    _navigator.popUntil(ModalRoute.withName(RouteNames.home));
  }
}
