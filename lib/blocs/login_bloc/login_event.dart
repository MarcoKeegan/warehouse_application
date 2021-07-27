part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends LoginEvent {
  @override 
  String toString() => 'AppStarted';
}

class LoggedIn extends LoginEvent {

  @override 
  String toString() => 'LoggedIn';
}

class LoggedOut extends LoginEvent {

  @override 
  String toString() => 'LoggedOut';
}