import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simat/Models/user.dart';
import 'package:simat/Utils/storage_io.dart';

class UserRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      await _auth.signInWithCredential(credential);
      return _auth.currentUser();
    } catch (e) {
      throw new Error();
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    print('isSignedIn');
    print(currentUser);
    if (currentUser != null) {
      return true;
    } else {
      final localdb = await StorageIO().readStorage('user');
      return localdb != null;
    }
  }

  Future<User> getUser() async {
    User result;
    final dataUser = await _auth.currentUser();
    if (dataUser != null) {
      result = User(
          id: dataUser.uid,
          displayName: dataUser.displayName,
          email: dataUser.email,
          photoUrl: dataUser.photoUrl ?? 'http://via.placeholder.com/200x150');
      return result;
    } else {
      await StorageIO().readStorage('user').then((info) {
        Map emp = jsonDecode(info);
        result = User.fromJson(emp);
      });
    }

    return result;
  }

  Future<void> googleSignOut() async {
    return Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
