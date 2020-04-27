import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
            backgroundColor: Colors.black87.withOpacity(0.3),
            children: <Widget>[
              Center(
                child: Column(children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.white54,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please Wait....",
                    style: TextStyle(color: Colors.white),
                  )
                ]),
              )
            ]));
  }
}
