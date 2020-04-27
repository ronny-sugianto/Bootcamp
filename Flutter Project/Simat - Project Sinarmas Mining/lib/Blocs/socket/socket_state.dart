import 'package:meta/meta.dart';

@immutable
abstract class SocketState {
  Object get condition => null;
}

class Init extends SocketState {}

class Connected extends SocketState {
//  final String status;
//  @override
//  String get condition => status;
//  Connected(this.status);
}

class Reconnect extends SocketState {}

class Disconnected extends SocketState {}
