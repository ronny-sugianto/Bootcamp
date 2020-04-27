import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/app/bloc.dart';
import 'package:simat/Blocs/report_nosync/bloc.dart';
import 'package:simat/Blocs/socket/bloc.dart';
import 'package:simat/Repositories/base_repository.dart';
import 'package:simat/Templates/Strings/app.dart';
import 'package:simat/Views/Home/Widgets/home_content.dart';
import 'package:simat/Views/Profile/profile_index.dart';
import 'Widgets/nav_bottom_bar.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  static const ROUTE_URL = '/home';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  MaterialColor colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ScanFloatingBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Color(0xffe60014),
            activeColor: CupertinoColors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled))
            ],
          ),
          tabBuilder: (context, i) {
            return _PageView(i);
          },
        ));
  }

  Widget _PageView(i) {
    return CupertinoPageScaffold(
      navigationBar: (i == 0) ? _HomeAppBar() : null,
      child: (i == 0) ? HomeContent() : ProfileView(),
    );
  }

  Widget _HomeAppBar() {
    return CupertinoNavigationBar(
        backgroundColor: Color(0xffe60014),
        middle: Image.asset(APP_LOGO_SIMAT),
        trailing: BlocBuilder<SocketBloc, SocketState>(
          builder: (context, state) {
            context.bloc<NsyncBloc>().add(getData());
            if (state is Connected) {
              return Icon(
                CupertinoIcons.circle_filled,
                color: Colors.green,
                size: 25,
              );
            }
            if (state is Reconnect) {
              return Icon(
                CupertinoIcons.circle_filled,
                color: Colors.blueAccent,
                size: 25,
              );
            }
            if (state is Disconnected) {
              return Icon(
                CupertinoIcons.circle_filled,
                color: Colors.red,
                size: 25,
              );
            }
            return Text(state.toString());
          },
        ));
  }
}
