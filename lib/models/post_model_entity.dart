import 'package:rate_my_parking/generated/json/base/json_field.dart';
import 'package:rate_my_parking/generated/json/post_model_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class PostModelEntity {

	List<PostModelData>? data;
	String? message;
	bool? error;
  
  PostModelEntity();

  factory PostModelEntity.fromJson(Map<String, dynamic> json) => $PostModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $PostModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PostModelData {

	int? id;
	String? image;
	@JSONField(name: "license_id")
	String? licenseId;
	String? latitude;
	String? longitude;
	String? address;
	String? description;
	double? rating;
	@JSONField(name: "user_id")
	int? userId;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	@JSONField(name: "comments_count")
	int? commentsCount;
  
  PostModelData();

  factory PostModelData.fromJson(Map<String, dynamic> json) => $PostModelDataFromJson(json);

  Map<String, dynamic> toJson() => $PostModelDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}