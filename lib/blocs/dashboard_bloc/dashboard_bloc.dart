import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/models/firebaseUid_models.dart';
import 'package:warehouse_application/models/firebaseUser_models.dart';
import 'package:warehouse_application/repo/repositories/firebaseUID_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.firebaseUser}) : super(DashboardInitial());

  late final UserData _userData;
  final FirebaseUIDRepository _firebaseUIDRepository = FirebaseUIDRepository();
  final FirebaseUser firebaseUser;

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LoadData) {
      yield DashboardLoading();
      try {
        _userData = await _firebaseUIDRepository.loginToDash(
            firebaseUser: firebaseUser);
        print(_userData.email);
        print(_userData.name);
        print(_userData.userId);
        print(_userData.roleId);
        print(_userData.firebaseUid);
        yield DashboardDone();
      } catch (e) {
        yield DashboardFailed();
      }
    }
  }
}
