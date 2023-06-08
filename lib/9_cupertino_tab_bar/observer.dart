import 'package:flutter/widgets.dart';

class NavigationLogger extends NavigatorObserver {
  final String tag;

  NavigationLogger(this.tag);

  @override
  void didPush(Route route, Route? previousRoute) {
    print('$NavigationLogger.$tag.didPush: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('$NavigationLogger.$tag.didPop: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {}

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {}

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {}

  @override
  void didRemove(Route route, Route? previousRoute) {}
}
