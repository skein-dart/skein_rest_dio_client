import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stub_data.g.dart';

@JsonSerializable()
class SignInRequest with EquatableMixin {

  final String username;

  final String password;

  SignInRequest(this.username, this.password);

  factory SignInRequest.fromJson(Map<String, dynamic> json) => _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);

  @override
  List<Object?> get props => [username, password];

}

@JsonSerializable()
class SignInResponse with EquatableMixin {

  @JsonKey(name: "AccessToken")
  final String accessToken;

  @JsonKey(name: "ExpiresIn")
  final int expiresIn;

  @JsonKey(name: "TokenType")
  final String tokenType;

  SignInResponse(this.accessToken, this.expiresIn, this.tokenType);

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

  @override
  List<Object?> get props => [accessToken, expiresIn, tokenType];

}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserProfile with EquatableMixin {

  final String firstName;

  final String lastName;

  UserProfile(this.firstName, this.lastName);

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [firstName, lastName];

}
