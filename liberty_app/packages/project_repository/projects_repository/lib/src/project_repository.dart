import 'package:project_api/project_api.dart';

/// {@template projects_repository}
/// A repository that handles project related requests.
/// {@endtemplate}
class ProjectsRepository {
  /// {@macro projects_repository}
  const ProjectsRepository({
    required ProjectsApi projectsApi,
  }) : _projectsApi = projectsApi;

  final ProjectsApi _projectsApi;

  /// Provides a [Stream] of all projects.
  Stream<List<Project>> getProjects(String owner) =>
      _projectsApi.projects(owner: owner);

  /// Saves a [project].
  ///
  /// If a [project] with the same id already exists, it will be replaced.
  Future<void> saveProject(Project project) =>
      _projectsApi.saveProject(project);
}
