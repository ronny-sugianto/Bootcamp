import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String displayName;
  String email;
  String password;
  String dateofbirth;
  String placeofbirth;
  String address;
  String phone;
  String photoUrl;
  String bloodGroup;
  String syncFlag;

  User({
    this.id,
    this.displayName,
    this.email,
    this.password,
    this.dateofbirth,
    this.placeofbirth,
    this.address,
    this.phone,
    this.photoUrl,
    this.bloodGroup,
    this.syncFlag,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
