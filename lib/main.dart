import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/app.dart';
import 'package:warehouse_application/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //setupServices();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp();
  runApp(App());
}