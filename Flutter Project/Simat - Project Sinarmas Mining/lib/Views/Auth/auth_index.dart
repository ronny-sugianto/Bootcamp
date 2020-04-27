import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simat/Blocs/auth/bloc.dart';
import 'package:simat/Blocs/socket/bloc.dart';
import 'package:simat/Repositories/base_repository.dart';
import 'package:simat/Templates/Strings/en.dart';
import 'package:simat/Views/Auth/Widgets/auth_form.dart';
import 'package:simat/Views/Home/home_index.dart';

class AuthView extends StatelessWidget {
  static const ROUTE_URL = '/auth';
  @override
  Widget build(BuildContext context) {
    getSync() async {
      await BaseRepository().syncAllData();
    }

    getSync();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, HomeView.ROUTE_URL);
        }
        if (state is AuthError) {
          Fluttertoast.showToast(
              msg: EN_MSG_ERROR_AUTH,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.black.withOpacity(0.8),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: SingleChildScrollView(
        child: Container(
          color: CupertinoColors.white,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                    child: Image.asset(
                  'assets/images/app-banner.png',
                  fit: BoxFit.contain,
                )),
              ),
              AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
