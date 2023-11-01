import 'package:flutter/material.dart';

class OnWillPop {
  final BuildContext context;
  final String title;
  final String message;
  final String yesText;
  final String noText;
  final Function() yesTap;
  final Function() noTap;
  OnWillPop({
    required this.context,
    required this.title,
    required this.message,
    required this.yesText,
    required this.noText,
    required this.yesTap,
    required this.noTap,
  });

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(noText),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(yesText),
              ),
            ],
          ),
        )) ??
        false;
  }
}
