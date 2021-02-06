import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key key,
    this.danger = false,
    this.title,
    this.actions,
    this.content,
    this.actionText,
    this.cancelFunction,
    this.actionFunction,
  }) : super(key: key);

  final bool danger;
  final Text title;
  final Text actionText;
  final Text content;
  final Function() cancelFunction;
  final Function() actionFunction;

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return CupertinoAlertDialog(
        title: title,
        content: Text("Are you sure you want to log out?"),
        actions: <Widget>[
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: cancelFunction,
              child: Text("Cancel")),
          CupertinoDialogAction(
            textStyle: danger ? TextStyle(color: Colors.red) : TextStyle(),
            isDefaultAction: true,
            onPressed: actionFunction,
            child: actionText,
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: this.title,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [

          TextButton(onPressed: cancelFunction,
              child: Text("Cancel")),

          TextButton(
            onPressed: actionFunction,
              child: actionText),


        ],
      );
    }
  }
}
