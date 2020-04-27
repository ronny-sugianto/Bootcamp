import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:simat/Models/employee.dart';
import 'package:simat/Models/report.dart';
import 'package:simat/Models/user.dart';
import 'package:simat/Services/base_service.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Templates/Strings/app.dart';
import 'package:simat/Utils/storage_io.dart';

class BaseRepository extends BaseService {
  LocalService _localService = new LocalService();
  Future<bool> addSyncAllData() async {
    Dio dio = await diodiodio;
    await _localService.open();

    try {
      var response = await dio.get('/logsync/dump/init/?secretkey=LASTDROP');
      if (response.statusCode == 200) {
        if (response.data != null) {
          print(response.data['user']);
          var dataUser = jsonDecode(jsonEncode(response.data['user']));
          List listDataUser = dataUser.map((f) => User.fromJson(f)).toList();
          if (listDataUser.length >= 0) {
            listDataUser.forEach((f) async {
              await _localService.db.insert('user', f.toJson());
            });
            print('sync db user : ok');
          }

          var dataEmployee = jsonDecode(jsonEncode(response.data['employee']));
          List listEmployee = dataEmployee
              .map((f) => Employee(
                  id: f['id'],
                  departmentId: f['departmentId'],
                  firstName: f['firstName'],
                  lastName: f['lastName'],
                  gender: f['gender'],
                  familyName: f['familyName'],
                  familyNumber: f['familyNumber'],
                  photoUrl: f['photoUrl'],
                  phone: f['phone'],
                  bloodType: f['bloodType'],
                  hiredDate: f['hiredDate'],
                  syncFlag: 'Y',
                  status: f['status']))
              .toList();
          if (listEmployee.length >= 0) {
            listEmployee.forEach((f) async {
              await _localService.db.insert('employee', f.toJson());
            });
            print('sync db employee : ok');
          }
          var dataReport = jsonDecode(jsonEncode(response.data['report']));
          List listReport = dataReport
              .map((f) => Report(
                    id: f['id'],
                    employeeId: f['employeeId'],
                    dateReport: f['dateReport'],
                    inTime: f['inTime'],
                    outTime: f['outTime'],
                    syncFlag: 'Y',
                    employee: Employee.fromJson(f['employee']),
                  ))
              .toList();
          if (listReport.length >= 0) {
            listReport.forEach((f) async {
              await _localService.db.insert('report', {
                'id': f.id,
                'dateReport': f.dateReport,
                'inTime': f.inTime,
                'outTime': f.outTime,
                'employeeId': f.employeeId,
                'syncFlag': f.syncFlag
              });
            });
          }
          print('sync db report : ok');
        }
        response = await dio.get('/logsync/0');
        if (response.statusCode == 200) {
          if (response.data.toString() != '') {
            await _localService.updateVersion(response.data['version']);
          }
          print('sync db version : ok');
        }
        await StorageIO().writeStorage('init', 'true');
        return true;
      }
      return false;
    } catch (e) {
      print('Data Repository - Add Employee Sync');
      print(e);
      return false;
    }
  }

  Future syncAllData() async {
    Dio dio = await diodiodio;
    try {
      var app_ver = await _localService.getVersion();
      var response = await dio.get('/logsync/' + app_ver);
      print(app_ver);
      if (response.statusCode == 200) {
        if (response.data.toString() != '') {
          int api = int.parse(response.data['version'].toString());
          int device = int.parse(app_ver.toString());
          //Processing SYNC USER & EMPLOYEE
          if (api > device) {
            print('======================');
            print(api);
            print(device);
            print('======================');
            response.data['data'].forEach((f) async {
              if (f['userId'] != null && f['employeeId'] == null) {
                switch (f['status']) {
                  case 'INSERT':
                    var getData = f['user'];
                    if (getData != null) {
                      var result =
                          await LocalService().addUser(User.fromJson(getData));
                      print(result);
                    }
                    break;
                  case 'UPDATE':
                    var getData = f['user'];
                    if (getData != null) {
                      var result =
                          await LocalService().deleteUser(getData['id']);
                      result =
                          await LocalService().addUser(User.fromJson(getData));
                      print(result);
                    }
                    break;
                  case 'DELETE':
                    var getData = f['user'];
                    if (getData != null) {
                      var result =
                          await LocalService().deleteUser(getData['id']);
                      print(result);
                    }
                    break;
                }
              }
              if (f['employeeId'] != null && f['userId'] == null) {
                switch (f['status']) {
                  case 'INSERT':
                    var getData = f['employee'];
                    if (getData != null) {
                      var result = await LocalService()
                          .addEmployee(Employee.fromJson(getData));
                      print(result);
                    }
                    break;
                  case 'UPDATE':
                    var getData = f['employee'];
                    if (getData != null) {
                      var result =
                          await LocalService().deleteEmployee(getData['id']);
                      result = await LocalService()
                          .addEmployee(Employee.fromJson(getData));
                      print(result);
                    }
                    break;
                  case 'DELETE':
                    var getData = f['employee'];
                    if (getData != null) {
                      var result =
                          await LocalService().deleteEmployee(getData['id']);
                      print(result);
                    }
                    break;
                }
              }
            });
            await LocalService().updateVersion(api);
          }
          //END Processing SYNC USER & EMPLOYEE
        }
        var data = await LocalService().getNoSyncDB('report');

        if (data.toString() != '' && data.toString() != '[]') {
          var tes = await dio.post("/report/sync", data: data);
          print('sync ===');
          print(tes);
          if (tes.statusCode == 200) {
            await LocalService().updateNoSyncDB('report');
          }
        }
      }
    } catch (e) {
      print('error sync ');
      print(e);
      print('=====');
    }
  }
}
