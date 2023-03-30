part of 'project_form_bloc.dart';

class ProjectFormState extends Equatable {
  const ProjectFormState({
    this.name = const ProjectName.pure(),
    this.description = const Description.pure(),
    this.tags = const ProjectName.pure(),
    this.staffs = const ProjectName.pure(),
    this.createdFrom = const Date.pure(),
    this.endOn = const Date.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.projects,
  });

  final ProjectName name;
  final Description description;
  final ProjectName tags;
  final ProjectName staffs;
  final Date createdFrom;
  final Date endOn;
  final FormzStatus status;
  final String? errorMessage;
  final List<Project>? projects;

  @override
  List<Object> get props =>
      [name, description, tags, staffs, createdFrom, endOn, status];

  ProjectFormState copyWith({
    ProjectName? name,
    Description? description,
    ProjectName? tags,
    ProjectName? staffs,
    Date? createdFrom,
    FormzStatus? status,
    Date? endOn,
    String? errorMessage,
    List<Project>? projects,
  }) {
    return ProjectFormState(
      name: name ?? this.name,
      projects: projects ?? this.projects,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      staffs: staffs ?? this.staffs,
      status: status ?? this.status,
      createdFrom: createdFrom ?? this.createdFrom,
      endOn: endOn ?? this.endOn,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
