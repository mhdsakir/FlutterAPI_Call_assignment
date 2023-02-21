import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyAlertDialog {
  static void verificationDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required Function() tabNo,
      required Function() tabYes,
      }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Yes'),
            isDestructiveAction: true,
            onPressed: tabYes,
          ),
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: tabNo,
          )
          
        ],
      ),
    );
  }
  static void confirmationDialog(
      {required BuildContext context,
      required String title,
      required String content,
      required Function() tabOk,
      }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('OK'),
            isDestructiveAction: true,
            onPressed: tabOk,
          ),
          
        ],
      ),
    );
  }
}