part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// class AppStarted extends LoginEvent {}

class Login extends LoginEvent {
  final String email;
  final String password;

  Login({required  this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoggedOut extends LoginEvent {}