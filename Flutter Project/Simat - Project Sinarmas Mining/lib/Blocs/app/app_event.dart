import 'package:meta/meta.dart';

@immutable
abstract class AppEvent {}

class AppSync extends AppEvent {}

class GetStatusAPI extends AppEvent {
  final status;
  GetStatusAPI(this.status);
}
