import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageIO {
  final storage = FlutterSecureStorage();

  Future<bool> writeStorage(key, value) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<String> readStorage(key) async {
    try {
      String value = await storage.read(key: key);
      return value;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  deleteStorage() async {
    await storage.deleteAll();
  }
}
