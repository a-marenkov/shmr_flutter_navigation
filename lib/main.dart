import 'package:flutter/material.dart';

import '1_push_pop_replace/app.dart';
import '2_navigator_key/app.dart';
import '3_named_routes/app.dart';
import '4_navigator_observers/app.dart';
import '5_args_and_results/app.dart';
import '6_will_pop_scope/app.dart';
import '7_dialogs_and_modals/app.dart';
import '8_tab_bar/app.dart';
import '9_cupertino_tab_bar/app.dart';

void main() {
  runApp(
    _getApp(
      RoutesAndNavigation.pushPopReplace,
    ),
  );
}

enum RoutesAndNavigation {
  pushPopReplace,
  navigatorKey,
  namedRoutes,
  navigatorObservers,
  argsAndResults,
  willPopScope,
  dialogsAndModals,
  tabBar,
  cupertinoTabBar,
}

Widget _getApp(RoutesAndNavigation type) {
  switch (type) {
    case RoutesAndNavigation.pushPopReplace:
      return const PushPopReplaceDemoApp();
    case RoutesAndNavigation.navigatorKey:
      return const NavigatorKeyDemoApp();
    case RoutesAndNavigation.namedRoutes:
      return const NamedRoutesDemoApp();
    case RoutesAndNavigation.navigatorObservers:
      return const NavigatorObserversDemoApp();
    case RoutesAndNavigation.argsAndResults:
      return const ArgsAndResultsDemoApp();
    case RoutesAndNavigation.willPopScope:
      return const WillPopScopeDemoApp();
    case RoutesAndNavigation.dialogsAndModals:
      return const DialogsAndModalsDemoApp();
    case RoutesAndNavigation.tabBar:
      return const TabBarDemoApp();
    case RoutesAndNavigation.cupertinoTabBar:
      return const CupertinoTabBarDemoApp();
  }
}
