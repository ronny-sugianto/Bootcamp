import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/auth/bloc.dart';
import 'package:simat/Models/user.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 195,
      color: Color(0xffff0017),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome,',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      if (state is Authenticated) {
                        return FittedBox(
                          child: Text(
                            state.data.displayName,
                            style: TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 28),
                          ),
                        );
                      }
                      return Text('');
                    }),
                  ],
                ),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  print('===========');
                  print(state);
                  if (state is Authenticated) {
                    return CachedNetworkImage(
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
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
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
                    );
                  }
                  return Container();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
