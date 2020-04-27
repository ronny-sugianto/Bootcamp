import 'package:meta/meta.dart';

@immutable
abstract class SocketEvent {
  get status => null;
}

class GetSocketStatus extends SocketEvent {
  final String _status;
  get status => _status;
  GetSocketStatus(this._status);
}
