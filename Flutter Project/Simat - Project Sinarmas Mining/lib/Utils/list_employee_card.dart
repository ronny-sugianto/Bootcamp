import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:simat/Models/employee.dart';
import 'package:simat/Models/report.dart';
import 'package:simat/Views/Report/Widgets/report_user_detail.dart';

class EmployeeCardList extends StatelessWidget {
  Employee data;
  EmployeeCardList({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: CupertinoColors.secondarySystemGroupedBackground,
        elevation: 10,
        child: ListTile(
          onTap: () {
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return ReportUserList(data);
                });
          },
          title: Text(
            data.firstName + ' ' + data.lastName,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            data.id,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
