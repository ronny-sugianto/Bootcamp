import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qrscan/qrscan.dart' as scanner;
import 'package:simat/Models/employee.dart';
import 'package:simat/Models/report.dart';
import 'package:simat/Templates/Strings/app.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportUserList extends StatefulWidget {
  Employee data;
  ReportUserList(this.data);

  @override
  _ReportUserListState createState() => _ReportUserListState();
}

class _ReportUserListState extends State<ReportUserList> {
  Uint8List bytes = Uint8List(0);

  generateQR() async {
    Uint8List result = await scanner.generateBarCode(widget.data.id);
    bytes = result;
    setState(() {});
  }

  _makePhoneCall(url) async {
    try {
      await launch('tel:' + url);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateQR();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: API_URL + widget.data.photoUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                        image: AssetImage('assets/images/dummy_avatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.data.firstName + ' ' + widget.data.lastName,
                  style: TextStyle(fontSize: 28),
                ),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 120,
                        child: Image.memory(
                          bytes,
                          scale: 1,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.group),
                                SizedBox(width: 10),
                                Text(widget.data.hiredDate),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.phone),
                                SizedBox(width: 10),
                                Text(widget.data.phone),
                              ],
                            ),
                            Divider(),
                            CupertinoButton(
                              onPressed: () {
                                _makePhoneCall("tel:" + widget.data.phone);
                                //_makePhoneCall(widget.data.employee.phone);
                              },
                              child: Text('Call Employee'),
                            )
                          ],
                        ))
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Emergency Contact',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              widget.data.familyName ?? 'no family name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CupertinoButton(
                          onPressed: () {
                            _makePhoneCall(widget.data.familyNumber);
                          },
                          color: CupertinoColors.systemRed,
                          padding: EdgeInsets.all(8.0),
                          borderRadius: BorderRadius.circular(10.0),
                          child: Text('Emergency Call'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
              color: CupertinoColors.systemGrey,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          )
        ],
      ),
    );
  }
}
