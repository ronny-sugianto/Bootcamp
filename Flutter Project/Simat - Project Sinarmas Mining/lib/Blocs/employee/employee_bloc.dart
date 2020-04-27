import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simat/Models/employee.dart';
import 'package:simat/Repositories/employee_repository.dart';
import 'package:simat/Repositories/report_repository.dart';
import './bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  @override
  EmployeeState get initialState => InitialEmployeeState();

  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    if (event is BackToInit) {
      yield InitialEmployeeState();
    }
    if (event is SearchEmployee) {
      yield* _searchResult(event.id);
    }
    if (event is SendAttendance) {
      yield* _sendAttendance(event.id, event.time, event.status);
    }

    if (event is SendAttendanceList) {
      yield* _sendAttendanceList(event.data);
    }
  }
}

Stream<EmployeeState> _searchResult(id) async* {
  yield SearchLoading();
  try {
    var result = await EmployeeRepository().getEmployeeById(id);
    print('=== _searchResult(ID) ===');
    print(result.runtimeType);
    if (result == null) {
      yield SearchNotFound();
    } else {
      if (result.runtimeType == Employee) {
        yield SearchLoaded(result);
      } else {
        yield SearchLoaded(Employee.fromJson(result));
      }
    }
  } catch (e) {
    print('AppBloc - _searchResult [ERROR]');
    print(e);
    yield SearchError();
  }
}

Stream<EmployeeState> _sendAttendanceList(data) async* {
  yield EmployeeAttendanceListLoading();
  try {
    var dataSend = {"dataReport": data};
    var result = await ReportRepository().sendAttendanceList(dataSend);
    print('====================');
    print(result);
    if (result == 'SUCCESS') {}
    yield EmployeeAttendanceListSuccess();
    if (result == 'DUPLICATE') {
      yield EmployeeAttendanceListDuplicate();
    }
    if (result == 'ERROR') {
      yield EmployeeAttendanceListError();
    }
  } catch (e) {
    print('Employee Bloc - Error');
    print(e);
    yield EmployeeAttendanceListError();
  }
}

Stream<EmployeeState> _sendAttendance(id, time, status) async* {
  yield EmployeeAttendanceLoading();
  try {
    var dataSend = {
      "employeeId": id,
      "time": time,
      "status": status,
    };
    var result = await ReportRepository().sendAttendance(dataSend);
    if (result == 'SUCCESS') {}
    yield EmployeeAttendanceSuccess();
    if (result == 'DUPLICATE') {
      yield EmployeeAttendanceDuplicate();
    }
    if (result == 'ERROR') {
      yield EmployeeAttendanceError();
    }
  } catch (e) {
    print('Employee Bloc - Error');
    print(e);
    yield EmployeeAttendanceError();
  }
}
