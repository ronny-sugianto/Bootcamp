import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/report_nosync/bloc.dart';
import 'package:simat/Blocs/socket/bloc.dart';

import 'package:simat/Utils/scan_form.dart';
import 'package:simat/Views/Auth/auth_index.dart';
import 'package:simat/Views/Home/home_index.dart';
import 'package:simat/Views/index.dart';

import 'Blocs/app/app_bloc.dart';
import 'Blocs/auth/bloc.dart';
import 'Blocs/employee/bloc.dart';
import 'Blocs/report/report_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (BuildContext context) => AppBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<ReportBloc>(
          create: (BuildContext context) => ReportBloc(),
        ),
        BlocProvider<EmployeeBloc>(
          create: (BuildContext context) => EmployeeBloc(),
        ),
        BlocProvider<NsyncBloc>(
          create: (BuildContext context) => NsyncBloc(),
        ),
        BlocProvider<SocketBloc>(
          create: (BuildContext context) => SocketBloc(),
          lazy: true,
        )
      ],
      child: CupertinoApp(
        title: 'SIMAT - Sinarmas Mining Attendance',
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
            textTheme:
                CupertinoTextThemeData(primaryColor: CupertinoColors.white)),
        initialRoute: SplashView.ROUTE_URL,
        routes: {
          AuthView.ROUTE_URL: (_) => AuthView(),
          SplashView.ROUTE_URL: (_) => SplashView(),
          HomeView.ROUTE_URL: (_) => HomeView(),
          ScanFormList.ROUTE_URL: (_) => ScanFormList()
        },
      ),
    );
  }
}
