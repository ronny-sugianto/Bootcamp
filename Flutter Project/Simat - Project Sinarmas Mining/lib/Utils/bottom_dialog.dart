import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomDialog extends StatelessWidget {
  final Widget message;

  BottomDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 10,
          //    height: MediaQuery.of(context).size.height - 200,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: message,
        ),
      ],
    );
  }
}
