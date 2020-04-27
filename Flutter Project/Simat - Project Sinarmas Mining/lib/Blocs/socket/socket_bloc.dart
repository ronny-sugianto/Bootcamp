import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simat/Repositories/base_repository.dart';
import 'package:simat/Services/socket_service.dart';
import './bloc.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  // ignore: non_constant_identifier_names
  SocketBloc() {
    socketStatus(status) {
      this.add(GetSocketStatus(status.toString()));
    }

    SocketService(socketStatus)..connect();
  }

  @override
  SocketState get initialState => Disconnected();

  @override
  Stream<SocketState> mapEventToState(
    SocketEvent event,
  ) async* {
    if (event is GetSocketStatus) {
      yield* _status(event.status);
    }
  }
}

Stream<SocketState> _status(status) async* {
  if (status == 'connect') {
    await BaseRepository().syncAllData();
    yield Connected();
  }
  if (status == 'reconnect') {
    yield Reconnect();
  }
  if (status == 'disconnect') {
    yield Disconnected();
  }
}
