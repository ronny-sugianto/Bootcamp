// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report(
    id: json['id'] as String ?? '',
    dateReport: json['dateReport'] as String ?? '',
    inTime: json['inTime'] as String ?? '',
    outTime: json['outTime'] as String ?? '',
    syncFlag: json['syncFlag'] as String ?? '',
    employeeId: json['employeeId'] as String ?? '',
    employee: json['employee'] == null
        ? null
        : Employee.fromJson(json['employee'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'dateReport': instance.dateReport,
      'inTime': instance.inTime,
      'outTime': instance.outTime,
      'employeeId': instance.employeeId,
      'syncFlag': instance.syncFlag,
      'employee': instance.employee,
    };
