
import 'package:firebase_auth/firebase_auth.dart';

class  LoginProvider {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> loginWithEmailandPass(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password
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

  Future<String> regisEmailandPass(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      return 'text';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    throw Exception();
  }
  
  void signOut () {
    auth.signOut();
  }
}


