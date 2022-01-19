// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stub_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) =>
    SignInRequest(
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      json['AccessToken'] as String,
      json['ExpiresIn'] as int,
      json['TokenType'] as String,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'AccessToken': instance.accessToken,
      'ExpiresIn': instance.expiresIn,
      'TokenType': instance.tokenType,
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      json['first_name'] as String,
      json['last_name'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
