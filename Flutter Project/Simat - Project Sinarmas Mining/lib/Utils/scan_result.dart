import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/employee/bloc.dart';
import 'package:simat/Blocs/report_nosync/bloc.dart';
import 'package:simat/Models/employee.dart';

class ShowScanResult extends StatelessWidget {
  final String id;
  ShowScanResult({this.id});

  @override
  Widget build(BuildContext context) {
    Employee data;
    String time =
        DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
    String status;
    // ignore: close_sinks

    context.bloc<EmployeeBloc>().add(SearchEmployee(id));

    return BlocListener<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
      if (state is SearchLoaded) {
        data = state.data;
        print(time);
        if (DateTime.now().hour > 5 && DateTime.now().hour < 13) {
          status = 'IN';
        } else {
          status = 'OUT';
        }
      }
      if (state is SearchError) {
        print('error');
      }
    }, child: BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        print('scan result view');
        print(state);
        if (state is SearchLoading || state is EmployeeAttendanceLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchLoaded) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: state.data.photoUrl ??
                          'https://img.icons8.com/color/48/000000/gender-neutral-user.png',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/dummy_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.firstName ?? '' + ' ' + data.lastName ?? '',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 2,
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 5.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Employee Information',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            child: Card(
                              color: Color(0xffeb2f06),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'BLOOD TYPE',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      height: 5,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      data.bloodType,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Card(
                              color: Color(0xffeb2f06),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'PHONE',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      height: 5,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      data.phone.toString() ?? '',
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Color(0xffeb2f06),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    data.gender ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 32),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 5.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Attendance',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(DateTime.now().day.toString() +
                                          '-' +
                                          DateTime.now().month.toString() +
                                          '-' +
                                          DateTime.now().year.toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(DateTime.now().hour.toString() +
                                          ':' +
                                          DateTime.now().minute.toString() +
                                          ':' +
                                          DateTime.now().second.toString()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Card(
                              color: Color(0xffeb2f06),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'TYPE',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      height: 5,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CupertinoButton(
                  onPressed: () {
                    context.bloc<EmployeeBloc>().add(SendAttendance(
                          id: id,
                          time: DateTime.now().toString(),
                          status: status,
                        ));
                    context.bloc<NsyncBloc>().add(getData());
                  },
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff1e90ff),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        }

        if (state is SearchNotFound) {
          return _message(context, 'Employee id not found');
        }
        if (state is EmployeeAttendanceSuccess) {
          return _message(context, 'Successfully Present');
        }
        if (state is EmployeeAttendanceDuplicate) {
          return _message(context, 'Sorry this employee was present on time');
        }
        if (state is EmployeeAttendanceError) {
          return _message(context, 'An error occurred in the service');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }

  _message(context, message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28),
        ),
        SizedBox(
          height: 10,
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: CupertinoColors.activeOrange,
          child: Text('Back'),
        )
      ],
    );
  }
}
