import 'package:meta/meta.dart';
import 'package:simat/Models/employee.dart';

@immutable
abstract class EmployeeState {}

class InitialEmployeeState extends EmployeeState {}

class SearchNotFound extends EmployeeState {}

class SearchLoading extends EmployeeState {}

class SearchError extends EmployeeState {}

class SearchLoaded extends EmployeeState {
  Employee data;
  SearchLoaded(this.data);
}

class EmployeeAttendanceSuccess extends EmployeeState {}

class EmployeeAttendanceDuplicate extends EmployeeState {}

class EmployeeAttendanceLoading extends EmployeeState {}

class EmployeeAttendanceError extends EmployeeState {}

class EmployeeAttendanceListSuccess extends EmployeeState {}
class EmployeeAttendanceListDuplicate extends EmployeeState {}
class EmployeeAttendanceListLoading extends EmployeeState {}
class EmployeeAttendanceListError extends EmployeeState {}