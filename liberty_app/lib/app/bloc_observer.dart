import 'package:bloc/bloc.dart';
import 'package:liberty_app/util/util.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    printOnDebug(event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    printOnDebug(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    printOnDebug(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printOnDebug(transition);
  }
}
