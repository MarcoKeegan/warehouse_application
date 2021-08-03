import 'package:firebase_auth/firebase_auth.dart';
import 'package:warehouse_application/models/firebaseUser_models.dart';

class  FirebaseRepository {
  FirebaseRepository({FirebaseAuth? firebaseAuth}) 
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<FirebaseUser> get user => _firebaseAuth
      .authStateChanges()
      .map((user) => user != null ? user.toUser : FirebaseUser.empty);

  Future<void> loginWithCredentials(
      {required String email, required String password}) async {
    // final String encryptedPassword =
    //     sha256.convert(utf8.encode(password)).toString();

    try {
      _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signUp(
    {required String email,required String password}) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }  
}

extension on User {
  FirebaseUser get toUser {
    return FirebaseUser(uid: uid, name: displayName, email: email);
  }
}


