part of 'dropdown_role_bloc.dart';

abstract class DropdownRoleState extends Equatable {
  const DropdownRoleState();
  
  @override
  List<Object> get props => [];
}

class DropdownRoleInitial extends DropdownRoleState {}

class DropdownRoleFailed extends DropdownRoleState {}

class DropdownRoleLoading extends DropdownRoleState {}

class DropdownRoleDone extends DropdownRoleState {
  final List<UserRole> role;

  DropdownRoleDone({required this.role});

  @override
  List<Object> get props => [role];
}
