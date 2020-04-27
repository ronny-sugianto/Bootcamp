import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'bottom_dialog.dart';
import 'loading_dialog.dart';

class PopDialog {
  static showLoadingDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return LoadingDialog();
        });
  }

  static showCenterDialog(BuildContext context, Widget child) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 10),
            child: AnimatedSwitcher(
              child: child,
              duration: Duration(seconds: 2),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            ),
          );
        });
  }

  static showBottomDialog(BuildContext context, Widget message) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedSwitcher(
            child: BottomDialog(
              message: message,
            ),
            duration: Duration(seconds: 1),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
