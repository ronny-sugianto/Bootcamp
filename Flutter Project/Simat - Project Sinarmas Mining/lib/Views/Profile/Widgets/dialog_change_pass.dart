import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/auth/auth_bloc.dart';
import 'package:simat/Blocs/auth/auth_state.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Services/user_service.dart';

class ProfileChangePassword extends StatefulWidget {
  @override
  _ProfileChangePasswordState createState() => _ProfileChangePasswordState();
}

class _ProfileChangePasswordState extends State<ProfileChangePassword> {
  String newpass;
  String success;
  bool changePass = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: state.data.photoUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
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
                ],
              ),
              success == 'Y' && changePass == true
                  ? _message(message: 'Successfuly changed password')
                  : success == 'N' &&
                          (changePass == true || changePass == false)
                      ? _message(message: 'Cannot changed password')
                      : changePass
                          ? Container(
                              margin: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(20.0),
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: CupertinoColors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 4,
                                              child: CupertinoTextField(
                                                prefix: Icon(
                                                  CupertinoIcons.padlock_solid,
                                                  size: 28,
                                                ),
                                                maxLength: 25,
                                                padding: EdgeInsets.all(10.0),
                                                clearButtonMode:
                                                    OverlayVisibilityMode
                                                        .editing,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                obscureText: true,
                                                decoration: BoxDecoration(),
                                                onChanged: (val) {
                                                  newpass = val;
                                                },
                                                placeholder:
                                                    'Enter new password',
                                              ),
                                            ),
                                            CupertinoButton(
                                              onPressed: () async {
                                                var changePass =
                                                    await UserService()
                                                        .changePassword(
                                                            state.data.id,
                                                            newpass);
                                                if (changePass == true) {
                                                  setState(() {
                                                    success = 'Y';
                                                  });
                                                } else {
                                                  setState(() {
                                                    success = 'N';
                                                  });
                                                }
                                              },
                                              child: Text('Change'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.all(10.0),
                                    color: CupertinoColors.systemRed,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(20.0),
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                children: <Widget>[
                                  CupertinoTextField(
                                    prefix: Icon(
                                      CupertinoIcons.padlock_solid,
                                      size: 28,
                                    ),
                                    clearButtonMode:
                                        OverlayVisibilityMode.editing,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: const BoxDecoration(),
                                    placeholder: 'Enter current password',
                                    onSubmitted: (val) async {
                                      try {
                                        bool data = await UserService()
                                            .checkPassword(
                                                state.data.email, val);
                                        if (data) {
                                          setState(() {
                                            changePass = true;
                                          });
                                        } else {
                                          setState(() {
                                            success = 'N';
                                            changePass = false;
                                          });
                                        }
                                      } catch (e) {
                                        setState(() {
                                          success = 'N';
                                        });
                                      }
                                    },
                                  ),
                                  CupertinoButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            )
            ],
          );
        }
        return Text('');
      },
    );
  }

  _message({message}) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          )
        ],
      ),
    );
  }
}
