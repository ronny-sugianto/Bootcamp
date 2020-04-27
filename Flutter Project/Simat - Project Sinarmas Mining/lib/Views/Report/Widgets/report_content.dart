import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simat/Blocs/report/bloc.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Utils/fab_custom.dart';
import 'package:simat/Utils/list_tile_report.dart';

import 'package:qrscan/qrscan.dart' as scanner;

class ReportContent extends StatefulWidget {
  @override
  _ReportContentState createState() => _ReportContentState();
}

class _ReportContentState extends State<ReportContent> {
  static const platform = const MethodChannel('info.mylabstudio.dev/smm');
  var employeeId;

  var date = DateTime.now();

  var empIdController = new TextEditingController();

  @override
  void initState() {
    _initDevice();
    super.initState();
  }

  @override
  Widget build(context) {
    ReportBloc _bloc = BlocProvider.of<ReportBloc>(context);
    date ?? _bloc.add(GetReportByDate(DateTime.now()));
    context.bloc<ReportBloc>().add(GetReportByDate(DateTime.now()));
    //context.bloc<NsyncBloc>().add(getData());
    final FocusNode _focusNode = new FocusNode();

    var childButtons = List<UnicornButton>();
    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
      heroTag: "Delete Local DB",
      backgroundColor: Color(0xff00a8ff),
      mini: true,
      child: Icon(Icons.restore_from_trash),
      onPressed: () {
        showCupertinoDialog(
            context: context,
            builder: (_) {
              return new CupertinoAlertDialog(
                title: new Text("Delete Confirmation"),
                content: new Text(
                    "Are you sure you want to delete all data in local db?"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text("Yes"),
                    onPressed: () async {
                      await LocalService().deleteAllReport('report');

                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
//            /   await LocalService().deleteAllReport('report');
      },
    )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
      heroTag: "directions",
      backgroundColor: Color(0xFFF97F51),
      mini: true,
      child: Icon(Icons.date_range),
      onPressed: () async {
        _showDatePicker(context, _bloc);
      },
    )));

    return Scaffold(
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Color(0xFF1B9CFC),
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.menu),
          childButtons: childButtons),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0),
            color: Color(0xffff0017),
            child: _menu(context, _bloc, _focusNode),
          ),
          BlocBuilder<ReportBloc, ReportState>(
            builder: (context, state) {
              print('=== [REPORT CONTENT] ====');
              print(state);
              if (state is ReportLoaded) {
                if (state.report.toString() == '[]') {
                  return Flexible(
                    child: Container(
                      child: Center(
                        child: Text('No Data'),
                      ),
                    ),
                  );
                } else {
                  return Flexible(
                    child: Container(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        slivers: [
                          CupertinoSliverRefreshControl(
                            onRefresh: () {
                              return Future<void>.delayed(
                                  const Duration(seconds: 1))
                                ..then<void>((_) {
                                  _bloc.add(GetReportByDate(date));
                                });
                            },
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return ReportCardList(
                                    data: state.report[index]);
                              },
                              childCount: state.report.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
              if (state is ReportLoading) {
                return Flexible(
                  child: Container(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              if (state is ReportError) {
                return Flexible(
                  child: Container(
                    child: Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                );
              }
              return Flexible(
                  child: Center(
                      child: Text(
                'No Data',
                style: TextStyle(fontWeight: FontWeight.w500),
              )));
            },
          )
        ],
      ),
    );
  }

  _showDatePicker(ctx, bloc) {
    return showCupertinoDialog(
        context: ctx,
        builder: (BuildContext context) {
          date = DateTime.now();
          return Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (dateTime) {
                          date = dateTime;
                          print(date);
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: CupertinoButton(
                            onPressed: () {
                              empIdController.text = '';
                              date != null
                                  ? bloc.add(GetReportByDate(date))
                                  : bloc.add(GetReportByDate(DateTime.now()));

                              Navigator.of(ctx).pop();
                            },
                            child: Text('Search'),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _menu(ctx, bloc, focusNode) {
    return Material(
      color: Colors.transparent,
      child: RawKeyboardListener(
        focusNode: focusNode,
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if ((event.runtimeType.toString() == 'RawKeyDownEvent' &&
              event.logicalKey.keyId ==
                  1108101562648)) //Enter Key ID from keyboard
          {
            _getIdCardInfo();
          }
        },
        child: ListTile(
          title: CupertinoTextField(
            controller: empIdController,
            readOnly: true,
            placeholder: 'Employee ID',
            prefix: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.person_outline),
            ),
            onEditingComplete: () {
              bloc.add(GetReportByEmployeeId(empIdController.text));
            },
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            clearButtonMode: OverlayVisibilityMode.editing,
            autocorrect: false,
          ),
          trailing: IconButton(
            icon: Icon(
              CupertinoIcons.fullscreen,
              color: Colors.white,
            ),
            onPressed: () async {
              empIdController.text = await scanner.scan();
              if (empIdController.text != '')
                bloc.add(GetReportByEmployeeId(empIdController.text));
            },
          ),
        ),
      ),
    );
  }

  Future _getIdCardInfo() async {
    String idCard;
    try {
      final String result = await platform.invokeMethod('scanIDCard');
      idCard = result;
      if (idCard != '') {
        //Navigator.of(context).pop();
        empIdController.text = idCard;
        Fluttertoast.showToast(
            msg: idCard,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.black.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 16.0);
        context.bloc<ReportBloc>().add(GetReportByEmployeeId(idCard));
      }

      setState(() {});
    } on PlatformException catch (e) {
      idCard = "'${e.message}'.";
    } finally {
//      await _disposeDevice();
    }
  }

  Future _initDevice() async {
    print('ok');
    try {
      final bool result = await platform.invokeMethod('initUhfReader');
      print('====NFC STATUS===');
      print(result);
    } on PlatformException catch (e) {
      print('=========================================');
      print(e);
      if (e.code == '001') {
        //message
      }
    }
  }
}
