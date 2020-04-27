import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simat/Blocs/auth/bloc.dart';
import 'package:simat/Utils/pop_dialog.dart';
import 'package:simat/Views/Auth/auth_index.dart';

import 'dialog_change_pass.dart';

class AccountMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthBloc authService = Provider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AuthView.ROUTE_URL, (Route<dynamic> route) => false);
        }
      },
      child: CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              PopDialog.showCenterDialog(context, ProfileChangePassword());
            },
            child: Text('Change Password'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              authService.add(SignOut());
            },
            child: Text('Sign Out'),
          )
        ],
      ),
    );
  }
}
