import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class CheckCurrentUser extends AuthEvent {}

class GoogleSignIn extends AuthEvent {}

class SignIn extends AuthEvent {
  final String email;
  final String password;
  SignIn({this.email, this.password});
}

class SignOut extends AuthEvent {}
