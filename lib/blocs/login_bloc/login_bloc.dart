import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.firebaseAuthRepo}) : super(LoginInitial());

  final FirebaseRepository firebaseAuthRepo;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) {
      yield LoginLoading();
      try {
        await firebaseAuthRepo.loginWithEmailandPass(
          email: event.email,
          password: event.password,
        );
        yield LoginDone();
      } catch (e) {
        yield LoginFailed();
      }
    }
  }
}
