import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/app/app_bloc.dart';
import 'package:simat/Blocs/app/app_state.dart';
import 'package:simat/Blocs/socket/bloc.dart';
import 'package:simat/Repositories/base_repository.dart';

class SyncView extends StatefulWidget {
  @override
  _SyncViewState createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  String message;
  bool _loading = true;
  Future _getSync() {
    message = 'Synchronization Process';
    Future.delayed(Duration(seconds: 5), () async {
      try {
        await BaseRepository().syncAllData();
        setState(() {
          message = 'Synchronization Process Complete';
        });
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        setState(() {
          message = 'Sync Process Failed';
        });
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop();
        });
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _loading ? CupertinoActivityIndicator() : Text(''),
        SizedBox(
          height: 10,
        ),
        BlocListener<SocketBloc, SocketState>(
          listener: (context, state) {
            if (state is Connected) {
              _loading = true;
            }
            if (state is Disconnected) {
              _loading = false;
            }
          },
          child: BlocBuilder<SocketBloc, SocketState>(
            builder: (context, state) {
              print('======================');
              print(state);
              if (state is Connected) {
                _getSync();
                return Text(
                  '${message}',
                  style: TextStyle(
                    color: CupertinoColors.black.withOpacity(0.5),
                    fontSize: 12,
                  ),
                );
              }
              if (state is Disconnected) {
                return Column(
                  children: <Widget>[
                    Text(
                      'Please connect to internet for sync',
                      style: TextStyle(
                        color: CupertinoColors.black.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                    CupertinoButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
              return Column(
                children: <Widget>[
                  Text(
                    'Reconnecting',
                    style: TextStyle(
                      color: CupertinoColors.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  CupertinoButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
