import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simat/Blocs/report_nosync/bloc.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Utils/list_tile_report.dart';
import 'home_header.dart';
import 'home_menu.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getData() {
      context.bloc<NsyncBloc>().add(getData());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            HomeHeader(),
            HomeMenu(),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.only(top: 10),
            child: BlocBuilder<NsyncBloc, NsyncState>(
              builder: (context, state) {
                if (state is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DataEmpty) {
                  return Center(
                    child: Text('No Pending Data'),
                  );
                }
                if (state is Error) {
                  return Center(
                    child: Text('Error a Service'),
                  );
                }
                if (state is Loaded) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      CupertinoSliverRefreshControl(
                        onRefresh: () {
                          return Future<void>.delayed(
                              const Duration(seconds: 1))
                            ..then<void>((_) {
                              context.bloc<NsyncBloc>().add(getData());
                            });
                        },
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ReportCardList(data: state.data[index]);
                          },
                          childCount: state.data.length,
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
