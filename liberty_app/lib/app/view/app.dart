import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liberty_app/app/theme.dart';
import 'package:liberty_app/presentation/screens/onboard/onboard.dart';
import 'package:liberty_app/app/app.dart';
import 'package:projects_repository/firebase_project_repository.dart';
import 'package:liberty_app/presentation/screens/project/project.dart';

import '../../presentation/screens/home/home_bloc/bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required FirebaseProjectRepository firebaseProjectRepository,
  })  : _authenticationRepository = authenticationRepository,
        _projectRepository = firebaseProjectRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final FirebaseProjectRepository _projectRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _projectRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => ProjectBloc(
                projectRepository: _projectRepository,
                authenticationRepository: _authenticationRepository)
              ..add(const ProjectStarted()),
          ),
          BlocProvider(
            create: (BuildContext context) => ProjectFormBloc(
              projectRepository: _projectRepository,
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => HomeBloc(
              projectRepository: _projectRepository,
              authenticationRepository: _authenticationRepository,
            )..add(const CountProjects()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      onGenerateRoute: (_) => OnboardPage.route(),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: AppRoutes.onGenerateAppViewPages,
      ),
    );
  }
}
