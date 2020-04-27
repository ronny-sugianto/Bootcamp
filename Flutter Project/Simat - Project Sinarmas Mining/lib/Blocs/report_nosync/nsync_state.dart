import 'package:meta/meta.dart';

@immutable
abstract class NsyncState {}

class Init extends NsyncState {}

class Loaded extends NsyncState {
  List data;
  Loaded(this.data);
}

class DataEmpty extends NsyncState {}

class Loading extends NsyncState {}

class Error extends NsyncState {}
