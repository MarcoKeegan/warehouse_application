import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/repo/repositories/regisAPI_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisState> {  
  RegisterBloc(this.regisRepository) : super(RegisState());

  final RegisApiRepository regisRepository;

  @override
  Stream<RegisState> mapEventToState(
    RegisterEvent event,
  ) async* {
      if (event is RequestRegis) {
        yield RegisLoading();
        try {
          await regisRepository.regisUser(email: event.email, name: event.nama, pass: event.pass ,roleId: event.roleId);
          yield RegisDone();
        } catch (e) {
          yield RegisFailed();
        }
      }
  }
}

