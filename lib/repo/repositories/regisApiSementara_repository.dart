import 'package:firebase_auth/firebase_auth.dart';

// class RegisFailure implements Exception {}

class RegisApiRepository {
  // RegisApiRepository({RegisterProvider? provider}) : _provider = provider ?? RegisterProvider();

  // final RegisterProvider _provider;
  
  FirebaseAuth auth = FirebaseAuth.instance;

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
}