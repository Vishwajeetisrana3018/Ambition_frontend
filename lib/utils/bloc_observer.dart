import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    debugPrint("${bloc.runtimeType.toString().padRight(16)} : "
        "${transition.currentState.runtimeType.toString().padRight(16)} -> "
        "${transition.nextState.runtimeType.toString().padRight(16)} | "
        "${transition.event.runtimeType}");
  }
}
