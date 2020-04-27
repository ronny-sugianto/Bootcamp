import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simat/Blocs/report/bloc.dart';
import 'Widgets/report_content.dart';

class ReportView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xffe60014),
        middle: Text(
          'Report',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: ReportContent(),
    );
  }
}
