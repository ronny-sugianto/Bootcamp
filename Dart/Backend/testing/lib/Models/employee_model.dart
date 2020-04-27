import 'package:testing/testing.dart';

class Employee extends ManagedObject<_Employee> implements _Employee {
  String get detaul => '$Title by $Name';
}

class _Employee {
  @primaryKey
  String id;

  @Column()
  String Name;
  @Column()
  String Title;

  // @override
  // Map<String, dynamic> asMap() => {'Name': Name, 'Title': Title};

  // @override
  // void readFromMap(Map<String, dynamic> body) {
  //   Name = body['Name'] as String;
  //   Title = body['Title'] as String;
  // }
}
