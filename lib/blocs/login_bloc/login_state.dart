part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginFailed extends LoginState {}

class LoginFailedNoDataFound extends LoginFailed {}

class LoginLoading extends LoginState {}

class LoginDone extends LoginState {}
