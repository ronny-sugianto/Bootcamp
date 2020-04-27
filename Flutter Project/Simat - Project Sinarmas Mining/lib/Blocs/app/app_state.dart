import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class AppSyncInitial extends AppState {}

class AppSyncLoading extends AppState {}

class AppSyncSuccess extends AppState {}

class AppSyncError extends AppState {}

class ONLINE extends AppState {}

class RECONNECT extends AppState {}

class OFFLINE extends AppState {}
