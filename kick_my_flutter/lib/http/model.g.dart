// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tache _$TacheFromJson(Map<String, dynamic> json) {
  return Tache()
    ..name = json['name'] as String
    ..path = json['path'] as String
    ..start = json['start'] as String
    ..deadline = json['deadline'] as String
    ..progression = json['progression'] as int
    ..userId = json['userId'] as String;
}

Map<String, dynamic> _$TacheToJson(Tache instance) => <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'start': instance.start,
      'deadline': instance.deadline,
      'progression': instance.progression,
      'userId': instance.userId,
    };
