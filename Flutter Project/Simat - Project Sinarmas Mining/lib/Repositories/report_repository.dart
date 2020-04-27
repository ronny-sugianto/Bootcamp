import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:simat/Models/report.dart';
import 'package:simat/Models/reportList.dart';
import 'package:simat/Services/base_service.dart';
import 'package:simat/Services/local_service.dart';

class ReportRepository extends BaseService {
  sendAttendance(data) async {
    Dio dio = await diodiodio;
    var result;
    try {
      result = await dio.post("/report", data: data);
      print(result);
      if (result.data != null) {
        if (result.data['reportId'] != null) {
          var toDB = await LocalService().addReport(data);
          print('=====TO DB===');
          print(toDB);
          return 'SUCCESS';
        }
        if (result.data['message'] != null) return 'DUPLICATE';
      } else {
        return 'ERROR';
      }
    } catch (e) {
      print('=================== ANEH');
      print(e);
      result = await LocalService().addReport(data);
      return result;
    }
  }

  sendAttendanceList(data) async {
    print(data);
    var result;
    Dio dio = await diodiodio;
    try {
      result = await dio.post("/report", data: data);
      print(result);
      if (result.data != null) {
        data['dataReport'].forEach((f) async {
          result = await LocalService().addReport(data);
          print('=====TO DB===');
          print(result);
        });
        return 'SUCCESS';
      } else {
        return 'ERROR';
      }
    } catch (e) {
      print('====');
      print(e);
      data['dataReport'].forEach((f) async {
        await LocalService().addReport(f);
      });
      return result;
    }
  }

  getReportByName(name) async {
    var result;
    Dio dio = await diodiodio;
    try {
      result = await dio.get("/report/datenow");
      if (result.statusCode == 200) {
        if (result.data.length > 0) {
          print(result.data);
          List<Report> reportModel =
              new ReportListResponse.fromJson(result.data).list;
          return reportModel;
        } else {
          return 'NULL';
        }
      } else {
        return 'NOT PERMIT';
      }
    } catch (e) {
      result = await LocalService().getReportByDate(DateTime.now());
      return result;
    }
  }

  getReportDate(date) async {
    var result;
    var parseDate = DateFormat('yyyy-MM-dd').parse(date.toString()).toString();
    print(parseDate.substring(0, 10));
    Dio dio = await diodiodio;
    try {
      result =
          await dio.get("/report?dateReport=" + parseDate.substring(0, 10));

      if (result.statusCode == 200) {
        if (result.data != null) {
          print('[GET REPORT BY DATE - ONLINE MODE]');
          print(result.data);
//          List.generate(result.data.length, (i) {
//            result.data[i]['employee']['photoUrl'] =
//                API_URL + result.data[i]['employee']['photoUrl'];
//          });
          List<Report> reportModel =
              new ReportListResponse.fromJson(result.data).list;
          print(result);
          return reportModel;
        } else {
          return 'NULL';
        }
      } else {
        return 'NOT PERMIT';
      }
    } catch (e) {
      //print(e);
      print(e);
      print('[GET REPORT BY DATE - OFFLINE MODE]');
      result = await LocalService().getReportByDate(date);
      return result;
    }
  }

  getReportByEmployeeId(id) async {
    var result;
    Dio dio = await diodiodio;
    try {
      result = await dio.get("/report/" + id);
      print(result);
      if (result.statusCode == 200) {
        if (result.data.length > 0) {
          print(result.data);
          List<Report> reportModel =
              new ReportListResponse.fromJson(result.data).list;
          return reportModel;
        } else {
          return 'NULL';
        }
      } else {
        return 'NOT PERMIT';
      }
    } catch (e) {
      result = await LocalService().getReportByEmployeeId(id);
      return result;
    }
  }
}
