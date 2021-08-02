import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/app.dart';
import 'package:warehouse_application/bloc_observer.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';
import 'package:warehouse_application/repo/repositories/regisAPI_repository.dart';


void main() async {
  // await Firebase.initializeApp();
  // Bloc.observer = CustomBlocObserver();
  // final FirebaseRepository _firebaseAuthRepo = FirebaseRepository();
  // runApp(App(firebaseAuth: _firebaseAuthRepo));

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp();
  final FirebaseRepository _firebaseAuthRepo = FirebaseRepository();
  final RegisApiRepository _regisApiRepository = RegisApiRepository();
  runApp(App(
    firebaseAuth: _firebaseAuthRepo,
    regisApiRepository: _regisApiRepository
  ));
}