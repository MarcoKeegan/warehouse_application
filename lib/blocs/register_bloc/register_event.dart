part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// class RegisSubmitted extends RegisterEvent {}

class RequestRegis extends RegisterEvent {
  final int roleId;
  final String email;
  final String nama;
  final String pass;

  RequestRegis({required this.roleId, required this.email, required this.nama, required this.pass});

  @override
  List<Object> get props => [roleId, email, nama, pass];
}





































// class RegisChanged extends RegisterEvent {
//   final int roleId;
//   final String name;
//   final String email;
//   final String pass;

//   RegisChanged({required this.roleId, required this.name, required this.email, required this.pass});
//    @override
//   List<Object> get props => [roleId, name, email, pass];
// }
// class RegisRoleChanged extends RegisterEvent {
//   final int roleId;

//   RegisRoleChanged({required this.roleId});
// }

// class RegisNameChanged extends RegisterEvent {
//   final String name;

//   RegisNameChanged({required this.name});
// }

// class RegisEmailChanged extends RegisterEvent {
//   final String email;

//   RegisEmailChanged({required this.email});
// }

// class RegisPassChanged extends RegisterEvent {
//   final String pass;

//   RegisPassChanged({required this.pass});
// }

