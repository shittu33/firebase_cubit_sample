import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liberty_app/app/routes.dart';
import 'package:liberty_app/app/theme.dart';
import 'package:liberty_app/presentation/screens/home/home_bloc/bloc.dart';
import 'package:liberty_app/presentation/screens/project/project.dart';
import 'package:liberty_app/presentation/screens/task/task.dart';
import 'package:liberty_app/presentation/widget/widgets.dart';

import '../../../../app/bloc/app_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  static route() => MaterialPageRoute<void>(builder: (_) => const HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SliverAppScaffold(
      fabHandler: () => Navigator.of(context).push(AddProjectScreen.route()),

      /// page Title
      title: const _PageTitle(),

      /// page trailing [ Alert IconButton]
      trailingWidget: const _NotificationIcon(),

      floatingIcon: Icons.add,

      /// body Widgets
      bodyWidgets: const [
        /// add 30px gap at the top
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
          ),
        ),

        /// Home Grid List
        _DashboardGrid(),

        /// add 20px gap
        SliverToBoxAdapter(child: SizedBox(height: 20)),

        /// Task List Header
        _TaskListHeader(),

        /// add some gap
        SliverToBoxAdapter(
          child: SizedBox(
            height: 15,
          ),
        ),

        /// Current Tasks
        _CurrentTaskList()
      ],
    );
  }
}

void projectHandler(context) {
  Navigator.of(context).push(ProjectListScreen.route());
}

void taskHandler(context) {
  Navigator.of(context).push(TaskListScreen.route());
}

class _CurrentTaskList extends StatelessWidget {
  const _CurrentTaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          return InkWell(onTap: () {}, child: const TaskItem());
        },
        childCount: 10,
      ),
    );
  }
}

class _TaskListHeader extends StatelessWidget {
  const _TaskListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Task in Progress',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: AppColors.black),
          ),
          TextButton(
            onPressed: () => taskHandler(context),
            child: Text(
              'See all',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: AppColors.primary, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  const _DashboardGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 24,
      childAspectRatio: 1.05,
      children: [
        InkWell(
          onTap: () => projectHandler(context),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is ProjectsCountedState) {
                return HomeGridItem(
                  icon: AssetsSvg.onboardMark(color: AppColors.white),
                  title: 'Projects',
                  count: state.count,
                  iconBackground: AppColors.brown,
                );
              } else {
                return HomeGridItem(
                  icon: AssetsSvg.onboardMark(color: AppColors.white),
                  title: 'Projects',
                  count: -1,
                  iconBackground: AppColors.brown,
                );
              }
            },
          ),
        ),
        InkWell(
          onTap: () => taskHandler(context),
          child: HomeGridItem(
            icon: AssetsSvg.taskIcon(),
            title: 'Tasks',
            count: 4,
            iconBackground: AppColors.blue,
          ),
        ),
        InkWell(
          onTap: () => taskHandler(context),
          child: const HomeGridItem(
            icon: Icon(
              Icons.check,
            ),
            title: 'Completed Task',
            count: 1,
            iconBackground: AppColors.green,
          ),
        ),
        InkWell(
          onTap: () => taskHandler(context),
          child: HomeGridItem(
            icon: AssetsSvg.overdueTask(),
            title: 'Overdue Task',
            count: 2,
            background: AppColors.gray.withOpacity(0.3),
            iconBackground: AppColors.gray,
          ),
        ),
      ],
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          return Text('Hi ${state.user.name}',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: AppColors.black));
        }),
        Text(
          'Welcome onboard',
          style: Theme.of(context).textTheme.overline,
        ),
      ],
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => taskHandler(context),
      icon: AssetsSvg.notificationIcon(width: 30, height: 30),
    );
  }
}
