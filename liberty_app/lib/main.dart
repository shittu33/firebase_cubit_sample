import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projects_repository/firebase_project_repository.dart';
import 'app/app.dart';

void main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationRepository = AuthenticationRepository();
      final firebaseProjectRepository = FirebaseProjectRepository();
      await authenticationRepository.user.first;
      runApp(App(
        authenticationRepository: authenticationRepository,
        firebaseProjectRepository: firebaseProjectRepository,
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}
