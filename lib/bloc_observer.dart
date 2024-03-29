import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('onEvent: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase blocBase, Object error, StackTrace stacktrace) {
    print('onError: $error');
    super.onError(blocBase, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('onTransition: $transition');
    super.onTransition(bloc, transition);
  }
}