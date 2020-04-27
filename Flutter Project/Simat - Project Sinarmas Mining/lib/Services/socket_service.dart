import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:simat/Templates/Strings/app.dart';

class SocketService {
  SocketIO socketIO;
  Function callback;

  SocketService(this.callback);
  connect() {
    try {
      socketIO = SocketIOManager()
          .createSocketIO(API_URL, '/', socketStatusCallback: callback);
      socketIO.destroy();
      socketIO.init();
      socketIO.connect();
    } catch (e) {
      print(e.toString());
    }
  }
}
