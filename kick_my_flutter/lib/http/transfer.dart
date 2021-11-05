import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'transfer.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
///
/// flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class SigninResponse {

  SigninResponse();

  String username = '';

  factory SigninResponse.fromJson(Map<String, dynamic> json) => _$SigninResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}

@JsonSerializable()
class SignupRequest {

  SignupRequest();

  String username = '';
  String password = '';

  factory SignupRequest.fromJson(Map<String, dynamic> json) => _$SignupRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}




@JsonSerializable()
class TaskDetailResponse {

  TaskDetailResponse();

  String name = '';
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime deadLine = DateTime.now();
  List<ProgressEvent> events = [];
  int percentageDone = 0;
  int percentageTimeSpent = 0;

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) => _$TaskDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDetailResponseToJson(this);
}

@JsonSerializable()
class ProgressEvent {

  ProgressEvent();

  int value = 0;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime timestamp = DateTime.now();

  factory ProgressEvent.fromJson(Map<String, dynamic> json) => _$ProgressEventFromJson(json);
  Map<String, dynamic> toJson() => _$ProgressEventToJson(this);
}

@JsonSerializable()
class HomeItemResponse {

  HomeItemResponse();

  int id = 0;
  String name = '';
  int percentageDone = 0;
  int percentageTimeSpent = 0;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime deadline = DateTime.now();

  factory HomeItemResponse.fromJson(Map<String, dynamic> json) => _$HomeItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeItemResponseToJson(this);
}

@JsonSerializable()
class AddTaskRequest {

  AddTaskRequest();

  String name = '';
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime deadLine = DateTime.now();

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) => _$AddTaskRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}

final _dateFormatter = DateFormat('MMM d, yyyy h:mm:ss a');
DateTime _fromJson(String date) => _dateFormatter.parse(date);
String _toJson(DateTime date) => _dateFormatter.format(date);