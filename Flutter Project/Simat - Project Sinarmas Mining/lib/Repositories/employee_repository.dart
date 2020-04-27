import 'package:dio/dio.dart';
import 'package:simat/Models/employee.dart';
import 'package:simat/Services/base_service.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Templates/Strings/app.dart';

class EmployeeRepository extends BaseService {
  getEmployeeById(id) async {
    Dio dio = await diodiodio;
    var response;
    try {
      response = await dio.get('/employee/' + id);
      print(id);
      if (response.statusCode == 200) {
        if (response.data.length > 0) {
          print('EmployeeRepository - getEmployeeById');

          response.data['photoUrl'] = API_URL + response.data['photoUrl'];

          //response.data['photoUrl'] = API_URL + response.data['photoUrl'];
          print(response.data.runtimeType);
          return Employee.fromJson(response.data);
        } else {
          return null;
        }
      }
      return null;
    } catch (e) {
      print('=============== NFC OFFLINE');
      response = await LocalService().getEmployeeById(id);
      print(response);
      return response;
    }
  }

  syncEmployee() async {
    var result;
    Dio dio = await diodiodio;
    try {
      result = await dio.get('/logsync');
      if (result != null && result.length > 0) {}
    } catch (e) {}
  }
}
