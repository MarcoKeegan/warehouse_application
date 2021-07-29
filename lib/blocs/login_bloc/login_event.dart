part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends LoginEvent {}

class LoggedIn extends LoginEvent {
  String email;
  String password;

  LoggedIn({required  this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoggedOut extends LoginEvent {}