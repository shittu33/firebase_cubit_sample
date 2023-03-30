import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:liberty_app/util/util.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.pure(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  late final StreamSubscription<User> _userSubscription;
  final AuthenticationRepository _authenticationRepository;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    printOnDebug("Firestore User");
    printOnDebug(event.user.email);
    final user =
        await _authenticationRepository.fireStoreUser(event.user.email ?? '');

    printOnDebug(user.toJson(user));

    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(user)
          : const AppState.pure(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
