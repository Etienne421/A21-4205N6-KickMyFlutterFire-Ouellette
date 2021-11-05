// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninResponse _$SigninResponseFromJson(Map<String, dynamic> json) {
  return SigninResponse()..username = json['username'] as String;
}

Map<String, dynamic> _$SigninResponseToJson(SigninResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) {
  return SignupRequest()
    ..username = json['username'] as String
    ..password = json['password'] as String;
}

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

TaskDetailResponse _$TaskDetailResponseFromJson(Map<String, dynamic> json) {
  return TaskDetailResponse()
    ..name = json['name'] as String
    ..deadLine = _fromJson(json['deadLine'] as String)
    ..events = (json['events'] as List<dynamic>)
        .map((e) => ProgressEvent.fromJson(e as Map<String, dynamic>))
        .toList()
    ..percentageDone = json['percentageDone'] as int
    ..percentageTimeSpent = json['percentageTimeSpent'] as int;
}

Map<String, dynamic> _$TaskDetailResponseToJson(TaskDetailResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadLine': _toJson(instance.deadLine),
      'events': instance.events,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
    };

ProgressEvent _$ProgressEventFromJson(Map<String, dynamic> json) {
  return ProgressEvent()
    ..value = json['value'] as int
    ..timestamp = _fromJson(json['timestamp'] as String);
}

Map<String, dynamic> _$ProgressEventToJson(ProgressEvent instance) =>
    <String, dynamic>{
      'value': instance.value,
      'timestamp': _toJson(instance.timestamp),
    };

HomeItemResponse _$HomeItemResponseFromJson(Map<String, dynamic> json) {
  return HomeItemResponse()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..percentageDone = json['percentageDone'] as int
    ..percentageTimeSpent = json['percentageTimeSpent'] as int
    ..deadline = _fromJson(json['deadline'] as String);
}

Map<String, dynamic> _$HomeItemResponseToJson(HomeItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': _toJson(instance.deadline),
    };

AddTaskRequest _$AddTaskRequestFromJson(Map<String, dynamic> json) {
  return AddTaskRequest()
    ..name = json['name'] as String
    ..deadLine = _fromJson(json['deadLine'] as String);
}

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadLine': _toJson(instance.deadLine),
    };
