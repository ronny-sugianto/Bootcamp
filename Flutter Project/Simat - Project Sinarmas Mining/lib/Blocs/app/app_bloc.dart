import 'dart:async';
import 'dart:isolate';
import 'package:bloc/bloc.dart';
import 'package:simat/Repositories/base_repository.dart';
import 'package:simat/Services/base_service.dart';
import 'package:simat/Services/local_service.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => AppSyncInitial();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppSync) {
      yield* _appSync();
    }

    if (event is GetStatusAPI) {
      yield* _getStatusAPI(event.status);
    }
  }
}

Stream<AppState> _appSync() async* {
  yield AppSyncLoading();
  try {
    var init = await LocalService().checkSetupApp();
    print(init);
    if (init == 'BELUM INIT') {
      await LocalService().deleteDB();
      await BaseRepository().addSyncAllData();
    }
    yield AppSyncSuccess();
  } catch (_) {
    print('APP BLOC - INIT');
    print(_);
    yield AppSyncError();
  }
}

Stream<AppState> _getStatusAPI(status) async* {
  print('_getStatusAPI');
  print(status);
  if (status.toString() == 'connect') {
    var data = await LocalService().getNoSyncDB('report');
    print('=====');
    print(data);
    yield ONLINE();
  }
  if (status.toString() == 'reconnect') {
    yield RECONNECT();
  }
  if (status.toString() == 'disconnect') {
    yield OFFLINE();
  }
}
