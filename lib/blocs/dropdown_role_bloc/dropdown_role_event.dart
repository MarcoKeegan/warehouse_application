part of 'dropdown_role_bloc.dart';

abstract class DropdownRoleEvent extends Equatable {
  const DropdownRoleEvent();

  @override
  List<Object> get props => [];
}

class LoadRole extends DropdownRoleEvent {
  final int roleId;

  LoadRole({int? roleId}) : roleId = roleId ?? 2;

  @override
  List<Object> get props => [
        roleId,
      ];
}