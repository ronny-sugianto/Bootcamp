import 'package:json_annotation/json_annotation.dart';
import 'package:simat/Models/employee.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  String id;
  String dateReport;
  String inTime;
  String outTime;
  String employeeId;
  String syncFlag;
  Employee employee;

  Report(
      {this.id,
      this.dateReport,
      this.inTime,
      this.outTime,
      this.syncFlag,
      this.employeeId,
      this.employee});
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
