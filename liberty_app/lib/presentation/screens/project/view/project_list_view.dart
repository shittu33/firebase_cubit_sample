import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liberty_app/app/theme.dart';
import 'package:liberty_app/presentation/screens/project/project.dart';
import 'package:liberty_app/presentation/widget/widgets.dart';
import 'package:liberty_app/util/util.dart';
import 'package:projects_repository/firebase_project_repository.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  static route() =>
      MaterialPageRoute<void>(builder: (_) => const ProjectListScreen());

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  void createProjectHandler() {
    Navigator.of(context).push(AddProjectScreen.route());
  }

  void addTaskHandler() {
    Navigator.of(context).push(AddTaskScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppScaffold(
      backIcon: AssetsSvg.backArrowIos(),
      trailingWidget: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 30.0, horizontal: AppSizes.appSideGap * 0.6),
        child: TextButton(
          onPressed: createProjectHandler,
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: AppColors.primary))),
          child: Text('Create Project',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontSize: 12, color: AppColors.primary)),
        ),
      ),
      bodyWidgets: [
        SliverToBoxAdapter(
          child: Text(
            'Projects',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(
            height: 21,
          ),
        ),

        /// Current Tasks
        BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
          if (state is ProjectsLoading) {
            return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()));
          }
          if (state is ProjectsLoaded) {
            printOnDebug("New Project");
            printOnDebug(state.projects);

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  var project = state.projects[index];
                  return InkWell(
                    onTap: () {},
                    child: ProjectItem(
                      addTaskHandler: addTaskHandler,
                      project: project,
                    ),
                  );
                },
                childCount: state.projects.length,
              ),
            );
          }
          return const SliverToBoxAdapter(
              child: Center(child: Text('Something went wrong!')));
        }),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 60,
          ),
        ),
      ],
    );
  }
}
