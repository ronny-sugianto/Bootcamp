import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/app/bloc.dart';
import 'package:simat/Blocs/auth/bloc.dart';
import 'package:simat/Templates/Strings/app.dart';
import 'package:simat/Templates/Strings/en.dart';

import 'Auth/auth_index.dart';
import 'Home/home_index.dart';

class SplashView extends StatelessWidget {
  static const ROUTE_URL = '/';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
// ignore: close_sinks
    AppBloc _blocApp = BlocProvider.of<AppBloc>(context);
    AuthBloc _blocAuth = BlocProvider.of<AuthBloc>(context);
    _blocApp.add(AppSync());
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppSyncSuccess) {
            _blocAuth.add(CheckCurrentUser());
          }
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, HomeView.ROUTE_URL);
            }
            if (state is Unauthenticated) {
              Navigator.pushReplacementNamed(context, AuthView.ROUTE_URL);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(),
              Container(
                padding: EdgeInsets.all(36),
                child: SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    APP_LOGO,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(
                    animating: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loading')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
