part of 'register_bloc.dart';

class RegisState extends Equatable {
  const RegisState();
  
  @override
  List<Object> get props => [];
}

class RegisInitial extends RegisState {}

class RegisFailed extends RegisState {}

class RegisLoading extends RegisState {}

class RegisDone extends RegisState {}



































// class RegisterDone extends RegisState {
//   late final int? roleId;
//   bool get isValidRoleId  => (roleId == 0 || roleId == 1);

//   late final String name;
//   bool get isValidUsername => name.length > 3;

//   late final String email;
//   bool get isValidEmail => email.contains('@');

//   late final String password;
//   bool get isValidPassword => password.length > 6;

//   RegisterDone({
//     this.roleId,
//     this.name = '',
//     this.email = '',
//     this.password = '',
//   });
//   RegisterDone copyWith({
//     required int roleId,
//     required String name,
//     required String email,
//     required String password,
//   }) {
//     return RegisterDone(
//       roleId: roleId,
//       name: name,
//       email: email,
//       password: password,
//     );
//   }
// }