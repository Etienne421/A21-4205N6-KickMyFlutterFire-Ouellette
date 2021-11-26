import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
///
/// flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class Tache {

  Tache();

  String name = '';
  String path = '';
  String start = '';
  String deadline = '';
  int progression = 0;
  String userId = '';

  factory Tache.fromJson(Map<String, dynamic> json) => _$TacheFromJson(json);
  Map<String, dynamic> toJson() => _$TacheToJson(this);
}