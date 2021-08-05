import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/app.dart';
import 'package:warehouse_application/bloc_observer.dart';
import 'package:warehouse_application/repo/repositories/createProduct_repository.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';
import 'package:warehouse_application/repo/repositories/regisAPI_repository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp();
  final FirebaseRepository _firebaseAuthRepo = FirebaseRepository();
  final RegisApiRepository _regisApiRepository = RegisApiRepository();
  final CreateProductRepository _createProductRepository = CreateProductRepository();
  runApp(App(
    firebaseAuth: _firebaseAuthRepo,
    regisApiRepository: _regisApiRepository,
    createProductRepository: _createProductRepository,
  ));
}