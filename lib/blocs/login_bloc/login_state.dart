part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginFailed extends LoginState {}

class LoginLoading extends LoginState {}

class LoginDone extends LoginState {
  // final String email;
  // final String password;

  // LoginDone({required this.email, required this.password});

  // @override
  // List<Object> get props => [email, password];
}
