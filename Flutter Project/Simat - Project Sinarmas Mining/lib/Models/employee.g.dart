// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
    id: json['id'] as String ?? '',
    departmentId: json['departmentId'] as int ?? '',
    firstName: json['firstName'] as String ?? '',
    lastName: json['lastName'] as String ?? '',
    gender: json['gender'] as String ?? '',
    familyName: json['familyName'] as String ?? '',
    familyNumber: json['familyNumber'] as String ?? '',
    photoUrl: json['photoUrl'] as String ?? '',
    phone: json['phone'] as String ?? '',
    placeofbirth: json['placeofbirth'] as String ?? '',
    dateofbirth: json['dateofbirth'] as String ?? '',
    bloodType: json['bloodType'] as String ?? '',
    hiredDate: json['hiredDate'] as String ?? '',
    status: json['status'] as String ?? '',
    syncFlag: json['syncFlag'] as String ?? '',
  );
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'departmentId': instance.departmentId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'familyName': instance.familyName,
      'familyNumber': instance.familyNumber,
      'photoUrl': instance.photoUrl,
      'phone': instance.phone,
      'dateofbirth': instance.dateofbirth,
      'placeofbirth': instance.placeofbirth,
      'bloodType': instance.bloodType,
      'hiredDate': instance.hiredDate,
      'status': instance.status,
      'syncFlag': instance.syncFlag,
    };
