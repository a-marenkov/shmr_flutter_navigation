import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _cupertinoPlatforms = {
  TargetPlatform.iOS,
  TargetPlatform.macOS,
};

extension TargetPlatformX on TargetPlatform {
  bool get isCupertino => _cupertinoPlatforms.contains(this);
}

typedef PlatformAdaptiveBuilder = Widget Function(
  BuildContext context,
  TargetPlatform platform,
);

class MyScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;

  const MyScaffold({
    required this.title,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    return platform.isCupertino
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: title,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: body,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: title,
            ),
            body: body,
          );
  }
}

class MyButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const MyButton({
    required this.child,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    return platform.isCupertino
        ? CupertinoButton(
            onPressed: onPressed,
            child: child,
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: child,
          );
  }
}
