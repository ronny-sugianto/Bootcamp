import 'package:meta/meta.dart';
import 'package:simat/Models/report.dart';

@immutable
abstract class ReportState {}

class ReportInit extends ReportState {}

class ReportError extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<Report> report;
  ReportLoaded(this.report);
}
