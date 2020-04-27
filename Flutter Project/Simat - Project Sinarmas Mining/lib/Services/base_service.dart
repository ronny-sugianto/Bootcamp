import 'package:dio/dio.dart';
import 'package:simat/Templates/Strings/app.dart';
import 'package:simat/Utils/storage_io.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseService {
  Future get diodiodio async {
    return Dio(BaseOptions(baseUrl: API_URL, headers: {
      'Authorization': 'Bearer ${await StorageIO().readStorage('token')}'
    }));
  }
}
