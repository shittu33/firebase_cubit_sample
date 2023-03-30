import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:liberty_app/presentation/screens/project/cubit/project_form_cubit.dart';
import 'package:liberty_app/presentation/screens/project/project.dart';
import 'package:liberty_app/presentation/widget/widgets.dart';
import 'package:liberty_app/app/theme.dart';
import 'package:liberty_app/util/log.dart';
import 'package:material_tag_editor/tag_editor.dart';

class AddProjectForm extends StatelessWidget {
  const AddProjectForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectFormBloc, ProjectFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          printOnDebug("Submitted Listener");
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Project Creation Failed!'),
              ),
            );
        }
      },
      child: Form(
        child: SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              /// add 20px top gap
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  /// project avatar
                  CircleAvatar(backgroundColor: AppColors.lightGray),

                  SizedBox(width: 15),

                  /// Name input Field
                  _NameInputField(),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  /// Created Data Form
                  _CreatedDateForm(),

                  SizedBox(width: 15),

                  /// End date Form
                  Expanded(child: _EndDateForm()),
                ],
              ),

              const SizedBox(height: 30),

              /// Assign Label
              const _AssignLabel(),

              const SizedBox(height: 10),

              /// Add Team member Form
              const _AddTeamMemberField(),

              const SizedBox(height: 20),

              /// Tag Form Field
              const _TagFormField(),

              // const _TagWidget(values: [],),

              const SizedBox(height: 20),

              /// Description Tag
              const _DescriptionTag(),

              const SizedBox(height: 10),

              /// Description Form
              const _DescriptionFormField(),

              const SizedBox(height: 20),

              /// create project button
              const _CreateProjectButton(),

              /// add some gap to bottom to make button visible while scrolling
              const SizedBox(height: 120)
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateProjectButton extends StatelessWidget {
  const _CreateProjectButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    projectCreationHandler() {
      context.read<ProjectFormBloc>().add(const SaveProjectForm());
    }

    return BlocBuilder<ProjectFormBloc, ProjectFormState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(child: CircularProgressIndicator())
            : ActionButton(
                text: 'Create Project',
                onPressed: projectCreationHandler,
              );
      },
    );
  }
}

class _NameInputField extends StatelessWidget {
  const _NameInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocBuilder<ProjectFormBloc, ProjectFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return UnderLinedTextFormField(
          onChanged: (name) =>
              context.read<ProjectFormBloc>().add(NameChanged(name)),
          label: const Text('Project Name'),
          errorText: state.name.invalid ? 'invalid Project Name' : null,
        );
      },
    ));
  }
}

class _DescriptionFormField extends StatelessWidget {
  const _DescriptionFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inputDecorationTheme = Theme.of(context).inputDecorationTheme;

    return BlocBuilder<ProjectFormBloc, ProjectFormState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 2,
          maxLines: 10,
          onChanged: (description) {
            context
                .read<ProjectFormBloc>()
                .add(DescriptionChanged(description));
            printOnDebug(
                "Description invalidity is ${state.description.invalid}");
          },
          decoration: InputDecoration(
            errorText: state.description.invalid
                ? 'Description has to be more than 30 characters'
                : null,
            border: (inputDecorationTheme.border as OutlineInputBorder)
                .copyWith(borderRadius: BorderRadius.circular(4)),
            focusedBorder:
                (inputDecorationTheme.focusedBorder as OutlineInputBorder)
                    .copyWith(borderRadius: BorderRadius.circular(4)),
            enabledBorder:
                (inputDecorationTheme.enabledBorder as OutlineInputBorder)
                    .copyWith(borderRadius: BorderRadius.circular(4)),
          ),
        );
      },
    );
  }
}

class _TagFormField extends StatelessWidget {
  const _TagFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectFormBloc, ProjectFormState>(
      buildWhen: (previous, current) => previous.tags != current.tags,
      builder: (context, state) {
        return UnderLinedTextFormField(
          label: const Text('Tags'),
          errorText: state.tags.invalid ? 'invalid Tags' : null,
          onChanged: (tags) =>
              context.read<ProjectFormBloc>().add(TagsChanged(tags)),
        );
      },
    );
  }
}

class _AddTeamMemberField extends StatelessWidget {
  const _AddTeamMemberField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectFormBloc, ProjectFormState>(
      buildWhen: (previous, current) => previous.staffs != current.staffs,
      builder: (context, state) {
        return UnderLinedTextFormField(
          label: const Text('Add team members'),
          suffix: const CircleAvatar(
            child: Icon(Icons.add),
          ),
          errorText: state.staffs.invalid ? 'invalid Staff Names' : null,
          onChanged: (tags) =>
              context.read<ProjectFormBloc>().add(StaffsChanged(tags)),
        );
      },
    );
  }
}

class _AssignLabel extends StatelessWidget {
  const _AssignLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Assign to:',
      style: Theme.of(context)
          .textTheme
          .overline
          ?.copyWith(color: AppColors.lightGray, fontSize: 13),
    );
  }
}

class _DescriptionTag extends StatelessWidget {
  const _DescriptionTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Description:',
      style: Theme.of(context)
          .textTheme
          .overline
          ?.copyWith(color: AppColors.lightGray, fontSize: 13),
    );
  }
}

class _EndDateForm extends StatelessWidget {
  const _EndDateForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectFormBloc, ProjectFormState>(
      buildWhen: (previous, current) => previous.endOn != current.endOn,
      builder: (context, state) {
        return DateFormPicker(
          label: 'End (to)',
          errorText: state.endOn.invalid ? 'invalid Date' : null,
          selectedDateHandler: (DateTime? dateTime) => context
              .read<ProjectFormBloc>()
              .add(EndDateChanged(dateTime.toString())),
        );
      },
    );
  }
}

class _CreatedDateForm extends StatelessWidget {
  const _CreatedDateForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocBuilder<ProjectFormBloc, ProjectFormState>(
      buildWhen: (previous, current) =>
          previous.createdFrom != current.createdFrom,
      builder: (context, state) {
        return DateFormPicker(
          label: 'Created (from)',
          errorText: state.createdFrom.invalid ? 'invalid Date' : null,
          selectedDateHandler: (DateTime? dateTime) => context
              .read<ProjectFormBloc>()
              .add(CreatedDateChanged(dateTime.toString())),
        );
      },
    ));
  }
}

class _TagWidget extends StatefulWidget {
  const _TagWidget({Key? key, required this.values}) : super(key: key);
  final List<String> values;

  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<_TagWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TagEditor(
      length: widget.values.length,
      delimiters: const [',', ' '],
      hasAddButton: true,
      inputDecoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Tags',
      ),
      onTagChanged: (newValue) {
        setState(() {
          widget.values.add(newValue);
        });
      },
      tagBuilder: (context, index) => _Chip(
        index: index,
        label: widget.values[index],
        onDeleted: (i) {},
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
