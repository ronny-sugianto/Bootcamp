import 'dart:convert';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:intl/intl.dart';
import 'package:simat/Models/employee.dart';
import 'package:simat/Models/report.dart';
import 'package:simat/Models/user.dart';
import 'package:simat/Utils/storage_io.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class LocalService {
  Database db;

  Future<void> open() async {
    final dbPath = await getDatabasesPath();
    final myDBpath = path.join(dbPath, 'app.db');
    db = await openDatabase(
      myDBpath,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE user(id TEXT PRIMARY KEY,displayName TEXT, email TEXT, password TEXT,dateofbirth TEXT,placeofbirth TEXT,address TEXT,phone TEXT,photoUrl TEXT,bloodGroup TEXT,syncFlag TEXT DEFAULT 'N')");
        await db.execute(
            "CREATE TABLE employee(id TEXT PRIMARY KEY,departmentId INT,firstName TEXT,lastName TEXT,gender TEXT,familyName TEXT,familyNumber TEXT,photoUrl TEXT,phone TEXT,dateofbirth TEXT,placeofbirth TEXT,bloodType TEXT,hiredDate Text,status TEXT,syncFlag TEXT DEFAULT 'N')");
        await db.execute(
            "CREATE TABLE department(id TEXT PRIMARY KEY,departmentName TEXT,syncFlag TEXT DEFAULT 'N')");
        await db.execute(
            "CREATE TABLE report(id TEXT PRIMARY KEY,dateReport TEXT,inTime TEXT, outTime TEXT,employeeId TEXT,syncFlag TEXT DEFAULT 'N')");
        await db.execute("CREATE TABLE version(id TEXT PRIMARY KEY)");
        await db.insert('version', {'id': 0});
      },
      version: 1,
    );
  }

  deleteAllReport(table) async {
    var result;
    try {
      await open();
      result = await db.rawQuery('delete from $table');
      return result;
    } catch (e) {
      print(e);
    }
  }

  getNoSyncDB(table) async {
    print('masuk');
    var result;
    try {
      await open();
      result = await db.rawQuery(
          "select id,employeeId,inTime,outTime,dateReport from $table where syncFlag='N'");

      //await db.close();
      return result;
    } catch (e) {
      //await db.close();
      print(e);
    }
  }

  updateNoSyncDB(table) async {
    try {
      await open();
      await db.update('$table', {'syncFlag': 'Y'},
          where: 'syncFlag = ?', whereArgs: ['N']);
      //await db.close();
    } catch (e) {
      //await db.close();
      print(e);
    }
  }

  getVersion() async {
    var result;
    try {
      await open();
      result = await db.rawQuery('select id from version');
      //await db.close();
      return result[0]['id'];
    } catch (e) {
      //await db.close();
      return e;
    }
  }

  updateVersion(version) async {
    try {
      await open();
      await db.update('version', {'id': version});
      //await db.close();
    } catch (e) {
      //await db.close();
      print(e);
    }
  }

  checkSetupApp() async {
    var result;
    try {
      result = await StorageIO().readStorage('init');
      print(result);
      if (result == null) {
        return 'BELUM INIT';
      }
      return 'SUDAH INIT';
    } catch (e) {
      print(e);
    }
  }

  signInWithSQLite(String email, String password) async {
    List<Map> result;
    try {
      await open();
      result = await db.rawQuery("Select * from user where email='$email'");
      var hash = result[0]['password'];
      var verify = DBCrypt().checkpw(password, hash);
      print('signInWithSQL');
      print(result.length);
      if (verify) {
        List<User> list = result.map((f) => User.fromJson(f)).toList();
        await StorageIO().writeStorage('user', jsonEncode(list[0].toJson()));
        // await db.close();
        return list[0].toJson();
      } else {
        //await db.close();
        print('========= ELSE');
        print(result.length);
        throw Error();
        //return null;
      }
    } catch (_) {
      //await db.close();
      print(_);
      throw Error();
    }
  }

  checkPermissionWithSQLite(String email) async {
    List<Map> result;
    await open();
    result = await db.rawQuery("Select * from user where email='$email'");
    if (result.length != 0) {
      List<User> list = result.map((f) => User.fromJson(f)).toList();
      //await db.close();
      return list;
    } else {
      return false;
    }
  }

  deleteDB() async {
    final dbPath = path.join(await getDatabasesPath(), 'app.db');
    await deleteDatabase(dbPath);
    print(dbPath);
    return dbPath;
  }
//
//  deleteDB() async {
//    final dbPath = await getDatabasesPath();
//    final myDBpath = path.join(dbPath, 'app.db');
//    await deleteDatabase(myDBpath);
//  }

  // USER LOCAL SERVICE
  addUser(User user) async {
    try {
      await open();
      await db.insert('user', {
        'id': user.id,
        'displayName': user.displayName,
        'email': user.email,
        'password': user.password,
        'dateofbirth': user.dateofbirth,
        'placeofbirth': user.placeofbirth,
        'address': user.address,
        'phone': user.phone,
        'photoUrl': user.photoUrl,
        'bloodGroup': user.bloodGroup,
        'syncFlag': 'Y',
      });
      // await db.close();
      return user;
    } catch (e) {
      // await db.close();
      return 'DUPLICATE USER';
    }
  }

  deleteUser(id) async {
    try {
      await open();
      await db.delete('user', where: 'id = ?', whereArgs: [id]);
      //await db.close();
      return 'OK';
    } catch (e) {
      //await db.close();
      return 'NO FOUND';
    }
  }

  getUser() async {
    await open();
    List<Map> list = await db.rawQuery('SELECT * FROM user');
    return List.generate(list.length, (i) {
      return User(
        id: list[i]['id'],
        email: list[i]['email'],
        password: list[i]['password'],
        displayName: list[i]['displayName'],
        photoUrl: list[i]['photoUrl'],
        phone: list[i]['phone'],
        placeofbirth: list[i]['placeofbirth'],
        dateofbirth: list[i]['dateofbirth'],
      );
    });
  }

  //EMPLOYEE
  addEmployee(Employee employee) async {
    try {
      await open();
      await db.insert(
          'employee',
          Employee(
                  id: employee.id,
                  departmentId: employee.departmentId,
                  firstName: employee.firstName,
                  lastName: employee.lastName,
                  gender: employee.gender,
                  familyName: employee.familyName,
                  familyNumber: employee.familyNumber,
                  photoUrl: employee.photoUrl,
                  phone: employee.phone,
                  bloodType: employee.bloodType,
                  hiredDate: employee.hiredDate,
                  status: employee.status,
                  syncFlag: 'Y')
              .toJson());
      // await db.close();
      return employee;
    } catch (e) {
      //await db.close();
      return 'DUPLICATE EMPLOYEE';
    }
  }

  deleteEmployee(id) async {
    try {
      await open();
      await db.delete('user', where: 'id = ?', whereArgs: [id]);
      //await db.close();
      return 'OK';
    } catch (e) {
      //await db.close();
      return 'NO FOUND';
    }
  }

  getEmployee() async {
    await open();
    List<Map> list = await db.rawQuery('SELECT * FROM user');
    return List.generate(list.length, (i) {
      return User(
        id: list[i]['id'],
        email: list[i]['email'],
        password: list[i]['password'],
        displayName: list[i]['displayName'],
        photoUrl: list[i]['photoUrl'],
        phone: list[i]['phone'],
        placeofbirth: list[i]['placeofbirth'],
        dateofbirth: list[i]['dateofbirth'],
      );
    });
  }

  updateUser(User user) async {
    await open();

    await db.update('user', user.toJson(),
        where: 'id = ?', whereArgs: [user.id]).then((data) {
      print(data.toString());
    }).catchError((e) {
      print('========');
      print(e);
    });
  }

  deleteProduct(User user) async {
    await open();
    // Delete a record
    await db.rawDelete('DELETE FROM user WHERE id = ?', [user.id]);
  }

  // EMPLOYEE LOCAL SERVICE
  getAllEmployee() async {
    await open();
    List<Map> list =
        await db.rawQuery("SELECT * FROM emloyee where syncFlag = 'N'");
    return List.generate(list.length, (i) {
      return Employee(
          id: list[i]['employeeId'],
          departmentId: list[i]['departmentId'],
          firstName: list[i]['firstName'],
          lastName: list[i]['lastName'],
          gender: list[i]['gender'],
          familyName: list[i]['familyName'],
          familyNumber: list[i]['familyNumber'],
          photoUrl: list[i]['photoUrl'],
          phone: list[i]['phone'],
          bloodType: list[i]['bloodType'],
          hiredDate: list[i]['hiredDate'],
          status: list[i]['status']);
    });
  }

  getEmployeeById(id) async {
    var result;
    try {
      await open();

      result = await db.rawQuery("Select * from employee where id='$id'");
      print('getEmployeeById - SQLite');
      print(result[0].toString());
      if (result.length > 0) {
        print(result[0]);
        return result[0];
      } else {
        print('========= ELSE');
        print(result.length);
        throw Error();
        //return null;
      }
    } catch (e) {
      print('local_service - getEmployeeById');
      print(e);
    }
  }

  changePass(id, newPass) {}
  // REPORT LOCAL SERVICE
  addReport(data) async {
    var result;
    var id = data['employeeId'];
    var date = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(data['time']))
        .toString();
    var time =
        DateFormat('HH:mm:ss').format(DateTime.parse(data['time'])).toString();
    print(date);
    print(time);
    print(data['status']);
    print('===============');
    print(data['sync']);
    try {
      await open();
      result = await db.rawQuery(
          "Select * from report where dateReport='$date' AND employeeId='$id' AND inTime IS NOT NULL AND outTime IS NOT NULL");
      print(result);
      print(result.length);

      if (result.length > 0) {
        return 'DUPLICATE';
      } else {
        switch (data['status']) {
          case 'IN':
            result = await db.rawQuery(
                "Select * from report where dateReport='$date' AND employeeId='$id' AND inTime IS NOT NULL");
            if (result.length > 0)
              return 'DUPLICATE';
            else {
              var inputIn = {
                "id": Uuid().v1(),
                "inTime": time,
                "dateReport": date,
                "employeeId": id,
                "syncFlag": data['sync'] ?? 'N',
              };
              await db.insert('report', inputIn);
              return 'SUCCESS';
            }
            break;
          case 'OUT':
            result = await db.rawQuery(
                "Select * from report where dateReport='$date' AND employeeId='$id' AND inTime IS NOT NULL AND outTime IS NULL");
            if (result.length > 0) {
              await db.update('report', {'outTime': time});
              return 'SUCCESS';
            } else {
              result = await db.rawQuery(
                  "Select * from report where dateReport='$date' AND employeeId='$id' AND inTime IS NULL AND outTime IS NOT NULL");
              if (result.length > 0) {
                return 'DUPLICATE';
              } else {
                var inputOut = {
                  "id": Uuid().v1(),
                  "outTime": time,
                  "dateReport": date,
                  "employeeId": id,
                  "syncFlag": data['sync'] ?? 'N',
                };
                await db.insert('report', inputOut);
                return 'SUCCESS';
              }
            }
            break;
        }
      }
    } catch (e) {
      print(e);
      return 'ERROR';
    }
  }

  getReportNoSync() async {
    var result;
    try {
      await open();
      result = await db.rawQuery(
          "SELECT * From report INNER JOIN employee ON employee.id = report.employeeId where report.syncFlag='N'");
      print('=======jjbjjjj=====');
      print(result);
      List<Report> datas = [];
      if (result.toString() != '[]') {
        //List<Report> reportModel = new ReportListResponse.fromJson(result).list;

        result.forEach((f) {
          datas.add(Report(
            id: f['id'].toString(),
            dateReport: f['dateReport'].toString(),
            inTime: f['inTime'].toString(),
            outTime: f['outTime'].toString(),
            employeeId: f['id'].toString(),
            employee: Employee(
              id: f['id'].toString(),
              departmentId: f['departmentId'],
              firstName: f['firstName'].toString(),
              lastName: f['lastName'].toString(),
              gender: f['gender'].toString(),
              familyName: f['familyName'].toString(),
              familyNumber: f['familyNumber'].toString(),
              photoUrl: f['photoUrl'].toString(),
              phone: f['phone'].toString(),
              dateofbirth: f['dateofbirth'],
              placeofbirth: f['placeofbirth'],
              bloodType: f['bloodType'].toString(),
              hiredDate: f['hiredDate'].toString(),
              status: f['status'].toString(),
            ),
          ));
        });
        return datas;
      } else {
        return 'NULL';
      }
    } catch (e) {
      print('local_service - getReportByDateNow');
      print(e);
    }
  }

  getReportByDate(date) async {
    var result;
    var dateParse = DateFormat('yyyy-MM-dd').format(date);
    print(dateParse);
    try {
//INNER JOIN employee ON employee.employeeId = report.employeeId where report.dateReport='2020-04-08'
      await open();
//      result =
//          await db.rawQuery("Select * from report where dateReport='$datenow'");
      result = await db.rawQuery(
          "SELECT * From report INNER JOIN employee ON employee.id = report.employeeId where dateReport='$dateParse'");
      print(result);
      List<Report> datas = [];
      if (result.toString() != '[]') {
        //List<Report> reportModel = new ReportListResponse.fromJson(result).list;

        result.forEach((f) {
          datas.add(Report(
            id: f['id'].toString(),
            dateReport: f['dateReport'].toString(),
            inTime: f['inTime'].toString(),
            outTime: f['outTime'].toString(),
            employeeId: f['id'].toString(),
            employee: Employee(
              id: f['id'].toString(),
              departmentId: f['departmentId'],
              firstName: f['firstName'].toString(),
              lastName: f['lastName'].toString(),
              gender: f['gender'].toString(),
              familyName: f['familyName'].toString(),
              familyNumber: f['familyNumber'].toString(),
              photoUrl: f['photoUrl'].toString(),
              phone: f['phone'].toString(),
              bloodType: f['bloodType'].toString(),
              hiredDate: f['hiredDate'].toString(),
              status: f['status'].toString(),
            ),
          ));
        });
        return datas;
      } else {
        return 'NULL';
      }
    } catch (e) {
      print('local_service - getReportByDateNow');
      print(e);
    }
  }

  getReportByEmployeeId(id) async {
    var result;
    try {
      await open();
      result = await db.rawQuery(
          "SELECT * FROM  report INNER JOIN employee ON employee.id = report.employeeId where report.employeeId='$id'");
      print('getReportByEmployeeId - SQLite');
      List<Report> datas = [];
      if (result.length > 0) {
        //List<Report> reportModel = new ReportListResponse.fromJson(result).list;
        result.forEach((f) {
          datas.add(Report(
            id: f['reportId'].toString(),
            dateReport: f['dateReport'].toString(),
            inTime: f['inTime'].toString(),
            outTime: f['outTime'].toString(),
            employeeId: f['employeeId'].toString(),
            employee: Employee(
              id: f['employeeId'].toString(),
              departmentId: f['departmentId'],
              firstName: f['firstName'].toString(),
              lastName: f['lastName'].toString(),
              gender: f['gender'].toString(),
              familyName: f['familyName'].toString(),
              familyNumber: f['familyNumber'].toString(),
              photoUrl: f['photos'].toString(),
              phone: f['phone'].toString(),
              bloodType: f['bloodType'].toString(),
              hiredDate: f['hiredDate'].toString(),
              status: f['status'].toString(),
            ),
          ));
        });
        return datas;
      }
      //await db.close();
    } catch (e) {
      print('getReportByEmployeeId - [ERROR]');
      print(e);
    }
  }
  // DEPARTMENT LOCAL SERVICE
}
