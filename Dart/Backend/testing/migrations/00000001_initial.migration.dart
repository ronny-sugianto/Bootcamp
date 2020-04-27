import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class MigrationDB extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_Employee", [
      SchemaColumn("id", ManagedPropertyType.string,
          isPrimaryKey: true,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("Name", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("Title", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    List<Map> seeds = [
      {"id": "satu", "Name": "JOKO", "Title": "STAFF"},
      {"id": "dua", "Name": "BODO", "Title": "STAFF"},
      {"id": "tiga", "Name": "KODO", "Title": "STAFF"},
      {"id": "empat", "Name": "YUDO", "Title": "STAFF"}
    ];
    for (final i in seeds) {
      await database.store.execute(
          'INSERT INTO _Employee (id,Name,Title) VALUES (@id,@Name,@Title)',
          substitutionValues: {
            'id': i['id'],
            'Name': i['Name'],
            'Title': i['Title'],
          });
    }
  }
}
