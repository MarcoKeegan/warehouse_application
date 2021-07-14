import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/models/user_models.dart';
import 'package:warehouse_application/repo/repositories/firebase_repository.dart';

part 'authentications_event.dart';
part 'authentications_state.dart';

class AuthenticationsBloc 
    extends Bloc<AuthenticationsEvent, AuthenticationsState> {
  AuthenticationsBloc({required FirebaseRepoAuth firebaseRepoAuth}) 
      : _firebaseRepoAuth = firebaseRepoAuth,
        super(AuthenticationsState.unknown()){

    _streamSubscription = _firebaseRepoAuth.user.listen((FirebaseUserModels user) {
      add(AuthenticationChangedState(user: user));
    });
  }

  StreamSubscription<FirebaseUserModels>? _streamSubscription;
  FirebaseRepoAuth _firebaseRepoAuth;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<AuthenticationsState> mapEventToState(
    AuthenticationsEvent event,
  ) async* {
    if (event is AuthenticationChangedState) {
      yield _mapEventToAuthenticationState(event);
    }
  }
  AuthenticationsState _mapEventToAuthenticationState(
      AuthenticationChangedState event) {
    if (event.user == FirebaseUserModels.empty) {
      return AuthenticationsState.unauthenticated();
    } else {
      return AuthenticationsState.authenticated(event.user);
    }
  }
}
