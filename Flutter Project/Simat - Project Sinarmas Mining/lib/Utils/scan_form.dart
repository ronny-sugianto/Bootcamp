import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/employee/bloc.dart';
import 'package:simat/Models/employee.dart';
import 'package:simat/Repositories/employee_repository.dart';

import 'list_employee_card.dart';

class ScanFormList extends StatefulWidget {
  static const ROUTE_URL = '/scanlist';
  @override
  _ScanFormListState createState() => _ScanFormListState();
}

class _ScanFormListState extends State<ScanFormList> {
  static const platform = const MethodChannel('info.mylabstudio.dev/smm');
  List resultScan = [];
  List resultScanFilltered = [];
  String status;
  AudioCache _audioCache;

  @override
  void initState() {
    context.bloc<EmployeeBloc>().add(BackToInit());
    _initDevice();
    _audioCache = AudioCache(
        prefix: 'audio/',
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));

    super.initState();
  }

  Future _getIdCardInfo() async {
    String idCard;
    try {
      final String result = await platform.invokeMethod('scanIDCard');
      idCard = result;

      if (idCard != null) {
        var check = await EmployeeRepository().getEmployeeById(idCard);

        print(check);
        if (check != null) {
          print(check.runtimeType == Employee);
          if (check.runtimeType == Employee) {
            resultScan.add(check);
          } else {
            print(check);
            resultScan.add(Employee.fromJson(check));
            print('=======');
            print(resultScan);
          }
          setState(() {});
        }
      }
    } on PlatformException catch (e) {
      idCard = "'${e.message}'.";
    } finally {
//      await _disposeDevice();
    }
  }

  Future _initDevice() async {
    try {
      final bool result = await platform.invokeMethod('initUhfReader');
      print('=======');
      print(result);
    } on PlatformException catch (e) {
      print('=========================================');
      print(e.details);
      if (e.code == '001') {
        //message
      }
    }
  }

  Future _disposeDevice() async {
    try {
      await platform.invokeMethod('disposeUhfReader');
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = new FocusNode();
    EmployeeBloc _bloc = BlocProvider.of<EmployeeBloc>(context);
    var date = DateTime.now().toString();
    var seen = Set<String>();
    var fillterResult = resultScan.where((str) => seen.add(str.id)).toList();
    fillterResult.forEach((data) {
      print(data.id);

      resultScanFilltered.add(
          {'employeeId': data.id, 'time': date.toString(), 'status': status});
    });
    print(resultScanFilltered.toString());
    print(DateTime.now());
    var seenAgain = Set<String>();
    var finalResult = resultScanFilltered
        .where((str) => seenAgain.add(str['employeeId']))
        .toList();
    finalResult.forEach((f) {
      _audioCache.play('nfc_tuing.mp3');
    });

    if (DateTime.now().hour > 5 && DateTime.now().hour < 13) {
      status = 'IN';
    } else {
      status = 'OUT';
    }
    setState(() {});
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Color(0xffe60014),
          middle: Text(
            'NFC SCAN',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        child: RawKeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKey: (RawKeyEvent event) async {
            if ((event.runtimeType.toString() == 'RawKeyDownEvent' &&
                event.logicalKey.keyId ==
                    1108101562648)) //Enter Key ID from keyboard
            {
              _getIdCardInfo();
            }
          },
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              print(state);
              if (state is EmployeeAttendanceListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is EmployeeAttendanceListSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'thank you, we will process the data immediately',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );

                return _message(context, 'Successfully Present',
                    'thank you, we will process the data immediately', [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ]);
              }
              if (state is EmployeeAttendanceListDuplicate) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'sorry, this data has already been present',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              }
              if (state is EmployeeAttendanceListError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'An error occurred during communication between servers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              }
              return Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButtonAnimator:
                      FloatingActionButtonAnimator.scaling,
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      print('==SAVE===');
                      print(fillterResult);
                      if (fillterResult.length > 0)
                        _bloc.add(SendAttendanceList(data: finalResult));
                      else
                        return _message(context, 'Failed to send datar',
                            'the data sent cannot be empty', [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ]);
                    },
                    isExtended: true,
                    elevation: 5,
                    backgroundColor: CupertinoColors.systemRed,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.share_up),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: fillterResult.length == 0
                              ? BoxFit.scaleDown
                              : BoxFit.contain,
                          image: AssetImage('assets/images/tap_nfc.png'),
                        )),
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: ListView.builder(
                              itemCount: fillterResult.length,
                              itemBuilder: (context, i) {
                                return EmployeeCardList(
                                  data: fillterResult[i],
                                );
                              }),
                        )
                      ],
                    ),
                  ));
            },
          ),
        ));
  }

  _message(context, title, desc, List<CupertinoDialogAction> widget) {
    return showCupertinoDialog(
        context: context,
        builder: (_) {
          return new CupertinoAlertDialog(
            title: new Text("Failed to send data"),
            content: new Text("the data sent cannot be empty"),
            actions: widget,
          );
        });
  }
}
