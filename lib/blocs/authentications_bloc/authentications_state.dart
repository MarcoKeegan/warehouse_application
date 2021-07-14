part of 'authentications_bloc.dart';

enum AuthenticationStatus {
  Unauthenticated,
  Authenticated,
  Unknown,
}

class AuthenticationsState extends Equatable {
  const AuthenticationsState._({
    this.user = FirebaseUserModels.empty,
    this.status =AuthenticationStatus.Unknown,
  });
  
  const AuthenticationsState.unknown() : this._();

  const AuthenticationsState.unauthenticated() : this._(status: AuthenticationStatus.Unauthenticated);

  const AuthenticationsState.authenticated(FirebaseUserModels user) : this._(user: user, status: AuthenticationStatus.Authenticated);

  final FirebaseUserModels user;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [user, status];
}


