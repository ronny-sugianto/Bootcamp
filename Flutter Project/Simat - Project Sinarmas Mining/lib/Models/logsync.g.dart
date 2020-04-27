// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logsync.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sync _$SyncFromJson(Map<String, dynamic> json) {
  return Sync(
    id: json['id'] as int ?? 0,
    employeeId: json['employeeId'] as String ?? '',
    userId: json['userId'] as String ?? '',
    status: json['status'] as String ?? '',
    employee: json['employee'] == null
        ? null
        : Employee.fromJson(json['employee'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SyncToJson(Sync instance) => <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'userId': instance.userId,
      'status': instance.status,
      'employee': instance.employee,
      'user': instance.user,
    };
