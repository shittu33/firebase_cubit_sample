import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:liberty_app/util/util.dart';
import 'package:projects_repository/firebase_project_repository.dart';

import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:new_project_form_inputs/new_project_form_inputs.dart';

part 'project_form_event.dart';

part 'project_form_state.dart';

class ProjectFormBloc extends Bloc<ProjectFormEvent, ProjectFormState> {
  ProjectFormBloc(
      {required this.projectRepository, required this.authenticationRepository})
      : super(const ProjectFormState()) {
    on<SaveProjectForm>(_onProjectFormSaved);
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<EndDateChanged>(_onEndChanged);
    on<CreatedDateChanged>(_onCreatedDateChanged);
    on<StaffsChanged>(_onStaffsChanged);
    on<TagsChanged>(_onTagsChanged);
    // _projectSubscription = projectRepository.projects.listen(
    //   (project) => add(const ProjectStarted()),
    // );
  }

  late final StreamSubscription<List<Project>> _projectSubscription;
  final AuthenticationRepository authenticationRepository;
  final FirebaseProjectRepository projectRepository;

  void _onProjectFormSaved(
      SaveProjectForm event, Emitter<ProjectFormState> emit) async {
    final state = this.state;

    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var newProject = Project(
        name: state.name.value,
        description: state.tags.value,
        isCompleted: false,
        tags: state.tags.value.split(','),
        staffs: state.tags.value.split(','),
        owner: authenticationRepository.currentUser.email,
        createdFrom: stringToTimeStamp(state.createdFrom.value),
        endOn: stringToTimeStamp(state.endOn.value),
      );
      await projectRepository.saveProject(newProject);
      // emit(ProjectsLoaded(projects: [...?state.projects, newProject]));

      printOnDebug(newProject.toJson());

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _onNameChanged(NameChanged event, Emitter<ProjectFormState> emit) {
    final name = ProjectName.dirty(event.name);
    var state = this.state;
    printOnDebug("_onNameChanged $name");
    printOnDebug("_onNameChanged validity is ${name.valid}");
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          name,
          state.description,
          state.staffs,
          state.tags,
          state.endOn,
          state.createdFrom
        ]),
      ),
    );
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<ProjectFormState> emit) {
    final description = Description.dirty(event.description);
    var state = this.state;
    printOnDebug("_onDescriptionChanged validity is ${description.valid}");
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate([
          description,
          state.name,
          state.staffs,
          state.tags,
          state.endOn,
          state.createdFrom
        ]),
      ),
    );
  }

  void _onCreatedDateChanged(
      CreatedDateChanged event, Emitter<ProjectFormState> emit) {
    final createdFrom = Date.dirty(event.date);
    var state = this.state;
    printOnDebug("_onCreatedDtateChanged $createdFrom");
    emit(
      state.copyWith(
        createdFrom: createdFrom,
        status: Formz.validate([
          createdFrom,
          state.name,
          state.staffs,
          state.tags,
          state.endOn,
          state.description
        ]),
      ),
    );
  }

  void _onEndChanged(EndDateChanged event, Emitter<ProjectFormState> emit) {
    final endOn = Date.dirty(event.date);
    var state = this.state;
    printOnDebug("_onEndChanged $endOn");
    emit(
      state.copyWith(
        endOn: endOn,
        status: Formz.validate([
          endOn,
          state.name,
          state.staffs,
          state.tags,
          state.description,
          state.createdFrom
        ]),
      ),
    );
  }

  void _onStaffsChanged(StaffsChanged event, Emitter<ProjectFormState> emit) {
    final staffs = ProjectName.dirty(event.staffs);
    var state = this.state;

    printOnDebug("_onStaffsChanged $staffs");
    emit(
      state.copyWith(
        staffs: staffs,
        status: Formz.validate([
          staffs,
          state.name,
          state.description,
          state.tags,
          state.endOn,
          state.createdFrom
        ]),
      ),
    );
  }

  void _onTagsChanged(TagsChanged event, Emitter<ProjectFormState> emit) {
    final tags = ProjectName.dirty(event.tags);
    var state = this.state;
    printOnDebug("_onTagsChanged $tags");
    emit(
      state.copyWith(
        tags: tags,
        status: Formz.validate([
          tags,
          state.name,
          state.staffs,
          state.description,
          state.endOn,
          state.createdFrom
        ]),
      ),
    );
  }

  stringToTimeStamp(timeString) =>
      Timestamp.fromDate(DateTime.parse(timeString));

  @override
  Future<void> close() {
    _projectSubscription.cancel();
    return super.close();
  }
}
