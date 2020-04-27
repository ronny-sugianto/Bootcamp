import 'package:flutter/material.dart';

import 'Widgets/Card_List.dart';
import 'Widgets/Header.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[Account_Header(), AccountCardList()],
    ));
  }
}
