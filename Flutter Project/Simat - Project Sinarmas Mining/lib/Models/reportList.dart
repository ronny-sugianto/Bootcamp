import 'package:json_annotation/json_annotation.dart';
import 'package:simat/Models/report.dart';

part 'reportList.g.dart';

@JsonSerializable()
class ReportListResponse {
  final List<Report> list;

  ReportListResponse({this.list});
  factory ReportListResponse.fromJson(List<dynamic> json) {
    List<Report> list = new List<Report>();
    list = json.map((i) => Report.fromJson(i)).toList();

    return new ReportListResponse(list: list);
  }
}
