import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simat/Repositories/report_repository.dart';
import './bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  @override
  ReportState get initialState => ReportInit();

  @override
  Stream<ReportState> mapEventToState(
    ReportEvent event,
  ) async* {
    if (event is GetReportByDate) {
      yield* _GetReportByDate(event.date);
    }
    if (event is GetReportByEmployeeId) {
      yield* _GetReportByEmployeeId(event.id);
    }
  }
}

Stream<ReportState> _GetReportByDate(date) async* {
  yield ReportLoading();
  try {
    var result = await ReportRepository().getReportDate(date);
    if (result == 'NULL') {
      yield ReportError();
    } else {
      yield ReportLoaded(result);
    }
  } catch (e) {
    print('GET REPORT BY DATE - ERROR');
    print(e);
    yield ReportError();
  }
}

Stream<ReportState> _GetReportByEmployeeId(id) async* {
  yield ReportLoading();
  try {
    //var result = await ReportRepository().getReportDateNow();

    var result = await ReportRepository().getReportByEmployeeId(id);
    print('_GetReportByEmployeeId');
    if (result.length == 4 || result == null) {
      yield ReportError();
    } else {
      yield ReportLoaded(result);
    }
  } catch (e) {
    print('GET REPORT BY EMPLOYEE ID - ERROR');
    print(e);
    yield ReportError();
  }
}
