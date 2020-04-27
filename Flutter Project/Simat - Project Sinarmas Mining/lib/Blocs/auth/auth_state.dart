import 'package:meta/meta.dart';
import 'package:simat/Models/user.dart';

@immutable
abstract class AuthState {}

class AuthInit extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {}

class SignInSuccess extends AuthState {}

class SignInFailed extends AuthState {}

class SignOutSuccess extends AuthState {}

class SignOutFailed extends AuthState {}

class Authenticated extends AuthState {
  final User data;
  Authenticated({this.data});
}

class Unauthenticated extends AuthState {}
