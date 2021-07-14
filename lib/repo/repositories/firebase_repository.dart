import 'package:firebase_auth/firebase_auth.dart';
import 'package:warehouse_application/models/user_models.dart';

class FirebaseRepoAuth {
  FirebaseRepoAuth({FirebaseAuth? firebaseAuth}) 
  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<FirebaseUserModels> get user => _firebaseAuth
  .authStateChanges()
  .map((user) => user != null ? user.toUser : FirebaseUserModels.empty);
}

  extension on User {
    FirebaseUserModels get toUser{
      return FirebaseUserModels(uid: uid, name: displayName, email: email);
  }
}