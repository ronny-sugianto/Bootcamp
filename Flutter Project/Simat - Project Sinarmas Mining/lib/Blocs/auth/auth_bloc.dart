import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:simat/Models/user.dart';
import 'package:simat/Repositories/user_repository.dart';
import 'package:simat/Services/local_service.dart';
import 'package:simat/Services/user_service.dart';
import 'package:simat/Utils/storage_io.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthInit();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckCurrentUser) {
      yield* _userState();
    }
    if (event is SignIn) {
      yield* _signIn(event.email, event.password);
    }
    if (event is GoogleSignIn) {
      yield* _googleSignIn();
    }
    if (event is SignOut) {
      yield* _signOut();
    }
  }
}

Stream<AuthState> _userState() async* {
  UserRepository _userRepository = UserRepository();
  UserService _userService = UserService();
  yield AuthLoading();
  try {
    final isSignedIn = await _userRepository.isSignedIn();
    print('_userState');
    print(isSignedIn);
    if (isSignedIn) {
      var data = await _userRepository.getUser();
      data = await _userService.checkPermission(data.email);
      yield Authenticated(data: data);
    } else {
      yield Unauthenticated();
    }
  } catch (_) {
    print('_userState - Error');
    print(_);
    await _userRepository.googleSignOut();
    yield Unauthenticated();
  }
}

Stream<AuthState> _signOut() async* {
  UserRepository _userRepo = UserRepository();
  yield AuthLoading();
  try {
    yield SignOutSuccess();
    await StorageIO().storage.delete(key: 'user');
    await _userRepo.googleSignOut();
  } catch (_) {
    yield SignOutFailed();
  }
}

Stream<AuthState> _signIn(String email, String password) async* {
  LocalService _localService = LocalService();
  print(email);
  print(password);
  yield AuthLoading();
  try {
    var data = await _localService.signInWithSQLite(email, password);
    print('signin with email - auth bloc');
    print(data);
    yield Authenticated(data: User.fromJson(data));
  } catch (_) {
    print('_signIn DBSQL');
    print(_);
    yield AuthError();
  }
}

Stream<AuthState> _googleSignIn() async* {
  UserRepository _userRepo = UserRepository();
  UserService _userService = UserService();
  yield AuthLoading();
  try {
    var googleAccount = await _userRepo.signInWithGoogle();
    var checkAccess = await _userService.checkPermission(googleAccount.email);
    print('_googleSignIn');
    print(checkAccess);
    if (checkAccess != null) {
      yield Authenticated(data: checkAccess);
    } else {
      await _userRepo.googleSignOut();
      yield Unauthenticated();
      yield AuthError();
    }
  } catch (_) {
    print('_googleSignIn - [ERROR]');
    print(_);
    yield AuthError();
  }
}
