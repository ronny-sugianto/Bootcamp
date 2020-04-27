import 'dart:convert';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:dio/dio.dart';
import 'package:simat/Models/user.dart';
import 'package:simat/Repositories/user_repository.dart';
import 'package:simat/Services/base_service.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Utils/storage_io.dart';

class UserService extends BaseService {
  Future<String> getToken() async {
    return await StorageIO().readStorage('token');
  }

  //Online Using API
  checkPermission(email) async {
    print('UserService checkPermission');
    print(email);
    Dio dio = await diodiodio;
    var result;
    try {
      //result = await dio.get('/user?email=' + email);
      result = await dio.get('/auth/w-email?email=' + email);
      print(result.data['token']);
      print('==== LIHAT ===');
      print(result.data.length);
      if (result.statusCode == 200) {
        if (result.data != null && result.data.length != 0) {
          print('UserService checkPermission - STATUS 200');
          print(result.data);
          await StorageIO().writeStorage('token', result.data['token']);
          return User.fromJson(result.data['user']);
        } else {
          return null;
        }
      }
    } catch (e) {
      await UserRepository().googleSignOut();
      print('checkPermission - userService');
      print(e);
      result = await LocalService().checkPermissionWithSQLite(email);
      return result[0];
    }
  }

  Future<bool> checkPassword(email, password) async {
    var result;
    Dio dio = await diodiodio;
    try {
      result = await dio.get('/user?email=' + email);
      if (result.data.toString() != '' && result.data.toString() != null) {
        print(result.data);
        var hash = result.data['password'];
        var verify = DBCrypt().checkpw(password, hash);
        print(verify);
        if (verify) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> changePassword(id, newPass) async {
    var result;
    Dio dio = await diodiodio;
    try {
      result = await dio.put('/user', data: {
        "id": id,
        "password": newPass,
      });
      print(result.data);
      if (result.statusCode == 200) {
        await LocalService().updateUser(User(id: id, password: newPass));
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getAllUser() async {
    Dio dio = await diodiodio;
    try {
      final response = await dio.get('/user');
      if (response.statusCode == 200) {
        final List data = jsonDecode(jsonEncode(response.data));
        print('=====GETALL USER====');
        print(data);
        LocalService().deleteDB();
        data.forEach((data) async {
          await LocalService().addUser(User.fromJson(data));
        });
        var datass = await LocalService().getUser();
        print(jsonEncode(datass));
        print('user_serivce - getalluser');

        return data;
      }
    } catch (e) {
      print(e);
      throw new Error();
    }
  }
}
