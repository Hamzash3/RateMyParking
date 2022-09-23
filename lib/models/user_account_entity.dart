import 'package:rate_my_parking/generated/json/base/json_field.dart';
import 'package:rate_my_parking/generated/json/user_account_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserAccountEntity {

	String? message;
	UserAccountData? data;
	bool? error;
  
  UserAccountEntity();

  factory UserAccountEntity.fromJson(Map<String, dynamic> json) => $UserAccountEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserAccountEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserAccountData {

	int? id;
	@JSONField(name: "license_id")
	String? licenseId;
	String? email;
	dynamic address;
	@JSONField(name: "access_token")
	String? accessToken;
  
  UserAccountData();

  factory UserAccountData.fromJson(Map<String, dynamic> json) => $UserAccountDataFromJson(json);

  Map<String, dynamic> toJson() => $UserAccountDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}