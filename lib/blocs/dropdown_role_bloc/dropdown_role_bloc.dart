import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/models/userRole_model.dart';
import 'package:warehouse_application/repo/repositories/roleApi_repository.dart';

part 'dropdown_role_event.dart';
part 'dropdown_role_state.dart';

class DropdownRoleBloc 
    extends Bloc<DropdownRoleEvent, DropdownRoleState> {
  DropdownRoleBloc({required this.apiRepository}) 
    : super(DropdownRoleInitial()) {
      add(LoadRole(roleId: 2));
  }
  final RoleApiRepository apiRepository;
  
  @override
  Stream<DropdownRoleState> mapEventToState(
    DropdownRoleEvent event,
  ) async* {
    if (event is LoadRole) {
      yield DropdownRoleLoading();
      try {
        final result = await apiRepository.getRole(roleId: event.roleId);
        yield DropdownRoleDone(role: result);
      } catch (e) {
        yield DropdownRoleFailed();
      }
    }
  }
}
