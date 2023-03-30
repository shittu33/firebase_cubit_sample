part of 'project_form_bloc.dart';

@immutable
abstract class ProjectFormEvent extends Equatable {
  const ProjectFormEvent() : super();
}

class SaveProjectForm extends ProjectFormEvent {
  const SaveProjectForm();


  @override
  List<Object> get props => [];
}

class NameChanged extends ProjectFormEvent {
  const NameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class DescriptionChanged extends ProjectFormEvent {
  const DescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class CreatedDateChanged extends ProjectFormEvent {
  const CreatedDateChanged(this.date);

  final String date;

  @override
  List<Object> get props => [date];
}

class EndDateChanged extends ProjectFormEvent {
  const EndDateChanged(this.date);

  final String date;

  @override
  List<Object> get props => [date];
}

class StaffsChanged extends ProjectFormEvent {
  const StaffsChanged(this.staffs);

  final String staffs;

  @override
  List<Object> get props => [staffs];
}

class TagsChanged extends ProjectFormEvent {
  const TagsChanged(this.tags);

  final String tags;

  @override
  List<Object> get props => [tags];
}
