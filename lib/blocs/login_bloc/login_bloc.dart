import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';
import 'package:warehouse_application/repo/repositories/firebaseUID_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required FirebaseRepository firebaseAuth}) 
      : _firebaseAuthRepo = firebaseAuth,
        super(LoginInitial());

  final FirebaseRepository _firebaseAuthRepo;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Login) {
      yield LoginLoading();
      try {
        await _firebaseAuthRepo.loginWithCredentials(
          email: event.email,
          password: event.password,
        );
        // print(event.email);
        // print(event.password);
        yield LoginDone();
      } on LoginFailureNoDataFound {
        yield LoginFailedNoDataFound();
      } catch (e) {
        yield LoginFailed();
      }
    }
  }
}
