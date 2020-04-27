import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Utils/pop_dialog.dart';
import 'package:simat/Utils/scan_form.dart';
import 'package:simat/Views/Home/Widgets/sync_view.dart';
import 'package:simat/Views/Report/report_index.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 160, left: 8, right: 8),
      width: double.infinity,
      height: 75,
      child: Card(
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _iconButton(
                  title: 'NFC',
                  icon: new Image.asset('assets/icons/nfc.png'),
                  callback: () {
                    Navigator.of(context).pushNamed(ScanFormList.ROUTE_URL);
                  }),
              VerticalDivider(color: Colors.black.withOpacity(0.5)),
              _iconButton(
                  title: 'Report',
                  icon: new Image.asset('assets/icons/report.png'),
                  callback: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return ReportView();
                    }));
                  }),
              VerticalDivider(color: Colors.black),
              _iconButton(
                  title: 'Sync',
                  icon: new Image.asset('assets/icons/sync.png'),
                  callback: () {
                    PopDialog.showCenterDialog(context, SyncView());
                  }),
            ],
          )),
    );
  }

  _iconButton({title, icon, callback}) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: callback,
            icon: icon,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CupertinoColors.black.withOpacity(0.6),
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
