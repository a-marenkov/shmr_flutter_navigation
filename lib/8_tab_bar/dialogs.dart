import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

abstract class Dialogs {
  const Dialogs._();

  static Future<bool?> showConfirmCloseCountDialog(BuildContext context) {
    final isCupertino = Theme.of(context).platform.isCupertino;

    return isCupertino
        ? showCupertinoDialog<bool>(
            context: context,
            routeSettings: const RouteSettings(
              name: '/alert_confirm_close_count',
            ),
            builder: (context) => const ConfirmCloseCountDialog(),
          )
        : showDialog<bool>(
            context: context,
            routeSettings: const RouteSettings(
              name: '/alert_confirm_close_count',
            ),
            barrierDismissible: false,
            builder: (context) => const ConfirmCloseCountDialog(),
          );
  }

  static Future<bool?> showConfirmCloseCountModal(BuildContext context) {
    final isCupertino = Theme.of(context).platform.isCupertino;

    return isCupertino
        ? showCupertinoModalPopup(
            context: context,
            routeSettings: const RouteSettings(
              name: '/modal_confirm_close_count',
            ),
            builder: (context) => const ConfirmCloseCountModal(),
          )
        : showModalBottomSheet(
            context: context,
            routeSettings: const RouteSettings(
              name: '/modal_confirm_close_count',
            ),
            builder: (context) => const ConfirmCloseCountModal(),
          );
  }
}

class ConfirmCloseCountDialog extends StatelessWidget {
  const ConfirmCloseCountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCupertino = Theme.of(context).platform.isCupertino;

    return isCupertino
        ? CupertinoAlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Count has not been changed'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          )
        : AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Count has not been changed'),
            actions: [
              SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('YES'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('NO'),
              ),
            ],
          );
  }
}

class ConfirmCloseCountModal extends StatelessWidget {
  const ConfirmCloseCountModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCupertino = Theme.of(context).platform.isCupertino;

    return isCupertino
        ? CupertinoActionSheet(
            title: const Text('Are you sure?'),
            message: const Text('Count has not been changed'),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Later'),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
            ],
          )
        : SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.check),
                  title: const Text('YES'),
                  onTap: () => Navigator.of(context).pop(true),
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text('NO'),
                  onTap: () => Navigator.of(context).pop(false),
                ),
                ListTile(
                  leading: const Icon(Icons.snooze),
                  title: const Text('LATER'),
                  onTap: () => Navigator.of(context).pop(false),
                ),
              ],
            ),
          );
  }
}
