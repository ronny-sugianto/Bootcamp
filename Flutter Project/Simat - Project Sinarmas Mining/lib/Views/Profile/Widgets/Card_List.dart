import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simat/Blocs/auth/bloc.dart';

class AccountCardList extends StatelessWidget {
  _cardTitle({title, icon}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xffe74c3c),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  _title({title}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
            color: Color(0xff8d0d0c),
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  _desc({desc}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        desc,
        style: TextStyle(
            color: Color(0xff2c3e50),
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Column(
            children: <Widget>[
              Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cardTitle(title: 'Personal Info', icon: Icons.people),
                    _title(title: 'Date of birth'),
                    _desc(
                        desc: DateFormat.yMMMMEEEEd('en_US')
                            .format(DateTime.parse(state.data.dateofbirth))),
                    _title(title: 'Place of birth'),
                    _desc(desc: state.data.placeofbirth),
                    _title(title: 'Address'),
                    _desc(desc: state.data.address),
                  ],
                ),
              ),
              Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _cardTitle(
                        title: 'Contact Information', icon: Icons.contacts),
                    _title(title: 'E-mail'),
                    _desc(desc: state.data.email),
                    _title(title: 'Phone number'),
                    _desc(desc: state.data.phone)
                  ],
                ),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
