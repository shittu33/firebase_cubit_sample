// part of 'project_form_cubit.dart';
//
// class AddProjectState extends Equatable {
//   const AddProjectState({
//     this.name = const ProjectName.pure(),
//     this.description = const Description.pure(),
//     this.tags = const ProjectName.pure(),
//     this.staffs = const ProjectName.pure(),
//     this.createdFrom = const Date.pure(),
//     this.endOn = const Date.pure(),
//     this.status = FormzStatus.pure,
//     this.errorMessage,
//   });
//
//   final ProjectName name;
//   final Description description;
//   final ProjectName tags;
//   final ProjectName staffs;
//   final Date createdFrom;
//   final Date endOn;
//   final FormzStatus status;
//   final String? errorMessage;
//
//   @override
//   List<Object> get props =>
//       [name, description, tags, staffs, createdFrom, endOn];
//
//   AddProjectState copyWith({
//     ProjectName? name,
//     Description? description,
//     ProjectName? tags,
//     ProjectName? staffs,
//     Date? createdFrom,
//     FormzStatus? status,
//     Date? endOn,
//     String? errorMessage,
//   }) {
//     return AddProjectState(
//       name: name ?? this.name,
//       description: this.description,
//       tags: this.tags,
//       staffs: this.staffs,
//       status: status ?? this.status,
//       createdFrom: this.createdFrom,
//       endOn: this.createdFrom,
//       errorMessage: errorMessage,
//     );
//   }
// }
