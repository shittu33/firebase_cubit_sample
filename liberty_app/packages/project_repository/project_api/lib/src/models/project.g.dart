// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String? ?? '',
    isCompleted: json['isCompleted'] as bool? ?? false,
    owner: json['owner'] as String? ?? '',
    tags: (json['tags'] as List?)?.map((dynamic e) => e.toString()).toList(),
    staffs:
        (json['staffs'] as List?)?.map((dynamic e) => e.toString()).toList(),
    createdFrom: json['createdFrom'] as Timestamp?,
    endOn: json['endOn'] as Timestamp?,
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) {
  final staffs = instance.staffs;
  return <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'owner': instance.owner,
    'description': instance.description,
    'isCompleted': instance.isCompleted,
    'tags': instance.tags,
    'staffs': staffs,
    'createdFrom': instance.createdFrom,
    'endOn': instance.endOn,
  };
}
