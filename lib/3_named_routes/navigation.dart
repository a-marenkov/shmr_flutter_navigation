import 'package:flutter/material.dart';

import 'routes.dart';

class NavigationManager {
  NavigationManager._();

  static final instance = NavigationManager._();

  final key = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => key.currentState!;

  void openCounter() {
    _navigator.pushNamed(RouteNames.counter);
  }

  void pop() {
    _navigator.pop();
  }

  void popToHome() {
    _navigator.popUntil(ModalRoute.withName(RouteNames.home));
    // _navigator.popUntil((route) => route.settings.name == RouteNames.home);
  }
}
