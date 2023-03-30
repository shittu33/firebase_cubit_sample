import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:project_api/project_api.dart';

/// {@template projects_api}
/// A Flutter implementation of the [ProjectsApi] that uses local storage.
/// {@endtemplate}
class FirebaseProjectRepository extends ProjectsApi {
  /// {@macro projects_api}
  FirebaseProjectRepository();

  /// Firestore collection
  final projectCollection = FirebaseFirestore.instance.collection('projects');

  /// The key used for storing the projects locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kProjectsCollectionKey = '__projects_collection_key__';

  @override
  Future<void> saveProject(Project project) async {
    await projectCollection.add(project.toJson());
    if (kDebugMode) {
      print('Project saved');
      print(project.toJson());
    }
  }

  /// Get all projects
  @override
  Stream<List<Project>> projects({String? owner}) {
    return projectCollection
        .where('owner', isEqualTo: owner)
        .snapshots()
        .map((snapshot) {
      if (kDebugMode) {
        print('Project Loaded');
      }
      final projects =
          snapshot.docs.map((doc) => Project.fromJson(doc.data())).toList();
      if (projects.isNotEmpty) {
        if (kDebugMode) {
          print(projects.last);
        }
      }
      return projects;
    });
  }

  ///This returns the Future of projects counts.
  Future<int> projectCount({String? owner}) async {
    final projects =
        await projectCollection.where('owner', isEqualTo: owner).get();
    final length = projects.docs.length;
    if (kDebugMode) {
      print('OnProjectCount of count $length');
    }
    return length;
  }
}
