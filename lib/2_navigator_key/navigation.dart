import 'package:flutter/material.dart';

import 'app.dart';

class NavigationManager {
  NavigationManager._();

  static final instance = NavigationManager._();

  final key = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => key.currentState!;

  void openHome(String title) {
    _navigator.pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return HomePage(title: title);
        },
      ),
    );
  }

  void openCounter(String title) {
    _navigator.push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CounterPage(title: title);
        },
      ),
    );
  }

  void pop() {
    _navigator.pop();
  }
}
