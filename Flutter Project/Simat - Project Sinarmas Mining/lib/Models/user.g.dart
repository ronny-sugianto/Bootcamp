// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String ?? '',
    displayName: json['displayName'] as String ?? '',
    email: json['email'] as String ?? '',
    password: json['password'] as String ?? '',
    dateofbirth: json['dateofbirth'] as String ?? '',
    placeofbirth: json['placeofbirth'] as String ?? '',
    address: json['address'] as String ?? '',
    phone: json['phone'] as String ?? '',
    photoUrl: json['photoUrl'] as String ?? '',
    bloodGroup: json['bloodGroup'] as String ?? '',
    syncFlag: json['syncFlag'] as String ?? '',
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'password': instance.password,
      'dateofbirth': instance.dateofbirth,
      'placeofbirth': instance.placeofbirth,
      'address': instance.address,
      'phone': instance.phone,
      'photoUrl': instance.photoUrl,
      'bloodGroup': instance.bloodGroup,
      'syncFlag': instance.syncFlag,
    };
