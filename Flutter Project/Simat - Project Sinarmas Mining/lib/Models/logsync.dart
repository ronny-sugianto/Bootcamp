import 'package:json_annotation/json_annotation.dart';
import 'package:simat/Models/employee.dart';
import 'package:simat/Models/user.dart';

part 'logsync.g.dart';

@JsonSerializable()
class Sync {
  int id;
  String employeeId;
  String userId;
  String status;
  Employee employee;
  User user;

  Sync(
      {this.id,
      this.employeeId,
      this.userId,
      this.status,
      this.employee,
      this.user});

  factory Sync.fromJson(Map<String, dynamic> json) => _$SyncFromJson(json);
  Map<String, dynamic> toJson() => _$SyncToJson(this);
}
