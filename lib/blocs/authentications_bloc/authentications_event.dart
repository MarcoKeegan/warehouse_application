part of 'authentications_bloc.dart';

abstract class AuthenticationsEvent extends Equatable {
  const AuthenticationsEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationChangedState extends AuthenticationsEvent {
  final FirebaseUserModels user;

  AuthenticationChangedState({required this.user});

  @override
  List<Object> get props => [user];
}