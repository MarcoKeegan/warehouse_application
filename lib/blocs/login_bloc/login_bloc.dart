import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) {
      yield LoginLoading();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: '',
          password: '',
        );
        yield LoginDone();
      } catch (e) {
        yield LoginFailed();
      }
    }
  }
}
