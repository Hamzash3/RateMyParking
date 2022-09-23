import 'package:rate_my_parking/generated/json/base/json_field.dart';
import 'package:rate_my_parking/generated/json/add_post_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AddPostEntity {

	AddPostData? data;
	String? message;
	bool? error;
  
  AddPostEntity();

  factory AddPostEntity.fromJson(Map<String, dynamic> json) => $AddPostEntityFromJson(json);

  Map<String, dynamic> toJson() => $AddPostEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AddPostData {

	int? id;
	String? image;
	@JSONField(name: "license_id")
	String? licenseId;
	String? latitude;
	String? longitude;
	String? address;
	String? description;
	int? rating;
	@JSONField(name: "user_id")
	int? userId;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
  
  AddPostData();

  factory AddPostData.fromJson(Map<String, dynamic> json) => $AddPostDataFromJson(json);

  Map<String, dynamic> toJson() => $AddPostDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}