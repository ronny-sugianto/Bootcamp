import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/auth/bloc.dart';

import 'Menu.dart';

class Account_Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          print('=========');
          print(state.data.photoUrl);
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.38,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/default_bg.jpg'),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(25)),
                        child: IconButton(
                          iconSize: 25,
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return AccountMenu();
                                });
                          },
                          padding: EdgeInsets.all(10.0),
                          icon: Icon(
                            Icons.menu,
                            color: CupertinoColors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  CachedNetworkImage(
                    imageUrl: state.data.photoUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider),
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
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            state.data.displayName,
                            style: TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Text('No Authorized Account !'),
        );
      },
    );
  }
}
