import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simat/Models/employee.dart';
import 'package:simat/Models/report.dart';
import 'package:simat/Templates/Strings/app.dart';
import 'package:simat/Views/Report/Widgets/report_user_detail.dart';

class ReportCardList extends StatelessWidget {
  Report data;

  ReportCardList({this.data});

  @override
  Widget build(BuildContext context) {
    print(data);
    return Card(
      elevation: 2,
      color: Colors.redAccent,
      child: ListTile(
        onTap: () {
          showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return ReportUserList(data.employee);
              });
        },
        leading: CachedNetworkImage(
          imageUrl: API_URL + data.employee.photoUrl ?? '',
          imageBuilder: (context, imageProvider) => Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
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
        title: Text(
          data.employee.firstName ?? '' + ' ' + data.employee.lastName ?? '',
          style: TextStyle(
              color: CupertinoColors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMMEEEEd('en_US')
                  .format(DateTime.parse(data.dateReport)) ??
              '-',
          style: TextStyle(
              color: CupertinoColors.white, fontWeight: FontWeight.w100),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            VerticalDivider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'IN',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  data.inTime ?? '',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            VerticalDivider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'OUT',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  data.outTime ?? '',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
