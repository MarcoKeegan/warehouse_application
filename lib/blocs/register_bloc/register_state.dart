part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

// class RegisterAuth extends RegisterState {
//   final int roleId;
//   final String name;
//   final String email;
//   final String pass;

//   RegisterAuth({required this.roleId, required this.name, required this.email, required this.pass});

//   @override
//   String toString() => 'RegisterAuth { roleId: $Role_ID}';
// }


