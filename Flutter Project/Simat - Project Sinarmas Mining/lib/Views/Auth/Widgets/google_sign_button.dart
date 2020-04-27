import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/auth/bloc.dart';
import 'package:simat/Templates/Strings/app.dart';
import 'package:simat/Templates/Strings/en.dart';

class GoogleSignButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc _authService = BlocProvider.of<AuthBloc>(context);
    return CupertinoButton(
        onPressed: () async {
          _authService.add(GoogleSignIn());
        },
        child: BlocBuilder(
          bloc: _authService,
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return _googleButton();
          },
        ));
  }

  _googleButton() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                  height: 30,
                  child: Image.asset(
                    GOOGLE_BUTTON_ICON,
                    fit: BoxFit.contain,
                  )),
            ),
            Expanded(
              flex: 6,
              child: Text(EN_GOOGLE_SIGNIN_BUTTON,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
