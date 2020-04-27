import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simat/Repositories/base_repository.dart';
import 'package:simat/Services/local_service.dart';
import './bloc.dart';

class NsyncBloc extends Bloc<NsyncEvent, NsyncState> {
  @override
  NsyncState get initialState => Init();

  @override
  Stream<NsyncState> mapEventToState(
    NsyncEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is getData) {
      yield* _getData();
    }
  }
}

Stream<NsyncState> _getData() async* {
  yield Loading();
  try {
    var data = await LocalService().getReportNoSync();
    print(data);
    print(data);
    if (data.toString() != 'NULL') {
      yield Loaded(data);
    } else {
      yield DataEmpty();
    }
  } catch (e) {
    print(e);
    yield Error();
  }
}
