// lib/data/models/jwt_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'jwtModel.g.dart'; // This will be generated by `build_runner`.

@JsonSerializable()
class JwtModel {
  @JsonKey(name: 'ROLES_IDS')
  final List<int>? rolesIds;

  @JsonKey(name: 'USER_ID')
  final int? userId;

  final String? sub;
  final int? iat; // Issued At
  final int? exp; // Expiration Time

  JwtModel({
    this.rolesIds,
    this.userId,
    this.sub,
    this.iat,
    this.exp,
  });

  factory JwtModel.fromJson(Map<String, dynamic> json) => _$JwtModelFromJson(json);

  Map<String, dynamic> toJson() => _$JwtModelToJson(this);
}