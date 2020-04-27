import 'package:json_annotation/json_annotation.dart';

import 'department.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  String id;
  int departmentId;
  String firstName;
  String lastName;
  String gender;
  String familyName;
  String familyNumber;
  String photoUrl;
  String phone;
  String dateofbirth;
  String placeofbirth;
  String bloodType;
  String hiredDate;
  String status;
  String syncFlag;

  Employee({
    this.id,
    this.departmentId,
    this.firstName,
    this.lastName,
    this.gender,
    this.familyName,
    this.familyNumber,
    this.photoUrl,
    this.phone,
    this.placeofbirth,
    this.dateofbirth,
    this.bloodType,
    this.hiredDate,
    this.status,
    this.syncFlag,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
