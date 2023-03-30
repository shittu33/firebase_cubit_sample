import 'package:flutter/material.dart';
import 'package:projects_repository/firebase_project_repository.dart';
import 'package:intl/intl.dart';
import '../../app/theme.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({Key? key, this.addTaskHandler, required this.project})
      : super(key: key);

  final Function()? addTaskHandler;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 4, right: 4),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10.06),
            // boxShadow: kElevationToShadow[3]
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowGrey,
                blurRadius: 2.0, // soften the shadow
                spreadRadius: 2.0, //extend the shadow
                offset: Offset(
                  1.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              ),
            ]),
        // elevation: 4,
        // borderRadius: BorderRadius.circular(10.06),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  // backgroundImage: NetworkImage(''),
                ),
                minLeadingWidth: 23,
                contentPadding: EdgeInsets.zero,
                title: Text(project.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontSize: 15)),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    width: 53,
                    height: 25,
                    child: TextButton(
                      onPressed: addTaskHandler,
                      child: Text('4d',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: AppColors.white, fontSize: 10)),
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.green),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 40,
                child: Stack(
                  children: [
                    Align(
                      alignment: const FractionalOffset(0.0, 0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Start',
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                      color: AppColors.red, fontSize: 9)),
                          const SizedBox(
                            height: 2,
                          ),
                          if (project.createdFrom != null)
                            Text(
                              DateFormat('d-M-yyyy')
                                  .format(project.createdFrom!.toDate())
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                      color: AppColors.black, fontSize: 10),
                            ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const FractionalOffset(0.4, 0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('End',
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                      color: AppColors.green, fontSize: 9)),
                          const SizedBox(
                            height: 2,
                          ),
                          if (project.endOn != null)
                            Text(
                              DateFormat('d-M-yyyy')
                                  .format(project.endOn!.toDate())
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                      color: AppColors.black, fontSize: 10),
                            ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const FractionalOffset(0.99, 0.6),
                      child: SizedBox(
                        height: 29,
                        width: 80,
                        child: TextButton(
                          onPressed: addTaskHandler,
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: const BorderSide(
                                      color: AppColors.primary))),
                          child: Text('Add Task',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      fontSize: 12, color: AppColors.primary)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
