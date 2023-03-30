// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:formz/formz.dart';
// import 'package:new_project_form_inputs/new_project_form_inputs.dart';
// import 'package:projects_repository/firebase_project_repository.dart';
//
// part 'project_form_state.dart';
//
// class AddProjectCubit extends Cubit<AddProjectState> {
//   AddProjectCubit(this._projectRepository, this._authenticationRepository)
//       : super(const AddProjectState());
//
//   final FirebaseProjectRepository _projectRepository;
//   final AuthenticationRepository _authenticationRepository;
//
//   void nameChanged(String value) {
//     final name = ProjectName.dirty(value);
//     emit(
//       state.copyWith(
//         name: name,
//         status: Formz.validate([
//           name,
//           state.description,
//           state.staffs,
//           state.tags,
//           state.endOn,
//           state.createdFrom
//         ]),
//       ),
//     );
//   }
//
//   void descriptionChanged(String value) {
//     final description = Description.dirty(value);
//     emit(
//       state.copyWith(
//         description: description,
//         status: Formz.validate([
//           description,
//           state.name,
//           state.staffs,
//           state.tags,
//           state.endOn,
//           state.createdFrom
//         ]),
//       ),
//     );
//   }
//
//   void createdFromChanged(String value) {
//     final createdFrom = Date.dirty(value);
//     emit(
//       state.copyWith(
//         createdFrom: createdFrom,
//         status: Formz.validate([
//           createdFrom,
//           state.name,
//           state.staffs,
//           state.tags,
//           state.endOn,
//           state.createdFrom
//         ]),
//       ),
//     );
//   }
//
//   void endOnChanged(String value) {
//     final endOn = Date.dirty(value);
//     emit(
//       state.copyWith(
//         endOn: endOn,
//         status: Formz.validate([
//           endOn,
//           state.name,
//           state.staffs,
//           state.tags,
//           state.endOn,
//           state.createdFrom
//         ]),
//       ),
//     );
//   }
//
//   void staffsChanged(String value) {
//     final staffs = ProjectName.dirty(value);
//     emit(
//       state.copyWith(
//         staffs: staffs,
//         status: Formz.validate([
//           staffs,
//           state.name,
//           state.staffs,
//           state.tags,
//           state.endOn,
//           state.createdFrom
//         ]),
//       ),
//     );
//   }
//
//   void tagsChanged(String value) {
//     final staffs = ProjectName.dirty(value);
//     emit(
//       state.copyWith(
//         staffs: staffs,
//         status: Formz.validate([
//           staffs,
//           state.name,
//           state.staffs,
//           state.tags,
//           state.endOn,
//           state.createdFrom
//         ]),
//       ),
//     );
//   }
//
//   Future<void> addProject() async {
//     if (!state.status.isValidated) return;
//     emit(state.copyWith(status: FormzStatus.submissionInProgress));
//     try {
//       var newProject = Project(
//         name: state.name.value,
//         description: state.description.value,
//         isCompleted: false,
//         tags: state.tags.value.split(','),
//         staffs: state.staffs.value.split(','),
//         owner: _authenticationRepository.currentUser.email,
//         createdFrom: stringToTimeStamp(state.createdFrom.value),
//         endOn: stringToTimeStamp(state.endOn.value),
//       );
//       await _projectRepository.saveProject(newProject);
//       if (kDebugMode) {
//         printOnDebug(newProject.toJson());
//       }
//       emit(state.copyWith(status: FormzStatus.submissionSuccess));
//     } on LogInWithEmailAndPasswordFailure catch (e) {
//       emit(
//         state.copyWith(
//           errorMessage: e.message,
//           status: FormzStatus.submissionFailure,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(status: FormzStatus.submissionFailure));
//     }
//   }
//
//   stringToTimeStamp(timeString) =>
//       Timestamp.fromDate(DateTime.parse(timeString));
// }
