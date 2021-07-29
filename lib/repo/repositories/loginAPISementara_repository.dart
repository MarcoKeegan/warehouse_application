
import 'package:firebase_auth/firebase_auth.dart';

class  LoginRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> loginWithEmailandPass(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); 
      return 'text';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    throw Exception();
  }
  void signOut () {
    auth.signOut();
  }
}


