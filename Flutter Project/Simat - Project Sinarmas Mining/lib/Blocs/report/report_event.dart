import 'package:meta/meta.dart';

@immutable
abstract class ReportEvent {}

class GetReportByDate extends ReportEvent {
  final date;
  GetReportByDate(this.date);
}

class GetReportByEmployeeId extends ReportEvent {
  final id;
  GetReportByEmployeeId(this.id);
}
