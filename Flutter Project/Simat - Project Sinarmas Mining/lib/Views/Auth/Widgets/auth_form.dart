import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/auth/bloc.dart';
import 'package:simat/Templates/Strings/en.dart';
import 'package:simat/Views/Auth/Widgets/stripe_divider.dart';

import 'google_sign_button.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthBloc _authService = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: _authService,
      builder: (context, state) {
        print(state);
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: <Widget>[
            _editText(EN_EMAIL_TEXT, _emailController,
                CupertinoIcons.mail_solid, false),
            SizedBox(
              height: 10,
            ),
            _editText(EN_PASSWORD_TEXT, _passwordController,
                CupertinoIcons.padlock_solid, true),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 15),
              alignment: Alignment.center,
              child: CupertinoButton(
                onPressed: () async {
                  _authService.add(SignIn(
                      email: _emailController.text,
                      password: _passwordController.text));
                },
                borderRadius: BorderRadius.circular(25),
                color: Color(0xffe60014),
                child: Text(EN_SIGNIN_BUTTON),
              ),
            ),
            StripDivinder(),
            GoogleSignButton(),
          ],
        );
      },
    );
  }

  _editText(title, controller, icon, bool password) {
    return CupertinoTextField(
        controller: controller,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        placeholder: title,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border(
              top: _borderSide(),
              bottom: _borderSide(),
              left: _borderSide(),
              right: _borderSide(),
            )),
        obscureText: password,
        prefix: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: Color(0xffff0017),
            size: 24,
          ),
        ),
        clearButtonMode: OverlayVisibilityMode.editing,
        maxLength: 40);
  }

  BorderSide _borderSide() {
    return BorderSide(
      color: CupertinoDynamicColor.withBrightness(
        color: Color(0x33000000),
        darkColor: Color(0x33FFFFFF),
      ),
      style: BorderStyle.solid,
      width: 0.0,
    );
  }
}
