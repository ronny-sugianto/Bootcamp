import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:simat/Utils/pop_dialog.dart';
import 'package:simat/Utils/scan_result.dart';

class ScanFloatingBar extends FloatingActionButton {
  @override
  Widget build(BuildContext context) {
    scan() async {
      var result = await scanner.scan();
      PopDialog.showBottomDialog(context, ShowScanResult(id: result));
    }

    return FloatingActionButton(
        backgroundColor: Color(0xffff0017),
        elevation: 5,
        onPressed: () {
          scan();
        },
        child: Image.asset(
          'assets/icons/scan.png',
          fit: BoxFit.contain,
          width: 25,
          height: 25,
          color: Colors.white,
        ));
  }
}
