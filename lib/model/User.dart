import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class user {
  /// The generated code assumes these values exist in JSON.
  final String firstName, lastName;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  final DateTime? dateOfBirth;

  user({required this.firstName, required this.lastName, this.dateOfBirth});

  /// Connect the generated [_$userFromJson] function to the `fromJson`
  /// factory.

  /// Connect the generated [_$userToJson] function to the `toJson` method.
}