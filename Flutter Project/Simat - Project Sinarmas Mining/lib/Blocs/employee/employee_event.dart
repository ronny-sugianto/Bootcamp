import 'package:meta/meta.dart';

@immutable
abstract class EmployeeEvent {}

class BackToInit extends EmployeeEvent {}

class SearchEmployee extends EmployeeEvent {
  final id;
  SearchEmployee(this.id);
}

class SendAttendanceList extends EmployeeEvent {
  final data;
  SendAttendanceList({this.data});
}

class SendAttendance extends EmployeeEvent {
  final id;
  final time;
  final status;
  SendAttendance({this.id, this.time, this.status});
}
