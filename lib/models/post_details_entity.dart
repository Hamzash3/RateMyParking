import 'package:rate_my_parking/generated/json/base/json_field.dart';
import 'package:rate_my_parking/generated/json/post_details_entity.g.dart';
import 'dart:convert';

import 'package:rate_my_parking/models/sub_models/post_comment_entity.dart';

@JsonSerializable()
class PostDetailsEntity {

	PostDetailsData? data;
	String? message;
	bool? error;
  
  PostDetailsEntity();

  factory PostDetailsEntity.fromJson(Map<String, dynamic> json) => $PostDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => $PostDetailsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PostDetailsData {

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
	List<PostCommentEntity>? comments;
  
  PostDetailsData();

  factory PostDetailsData.fromJson(Map<String, dynamic> json) => $PostDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => $PostDetailsDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
/*

@JsonSerializable()
class PostDetailsDataComments {

	@JSONField(name: "post_id")
	int? postId;
	String? comment;
	@JSONField(name: "created_at")
	String? createdAt;
  
  PostDetailsDataComments();

  factory PostDetailsDataComments.fromJson(Map<String, dynamic> json) => $PostDetailsDataCommentsFromJson(json);

  Map<String, dynamic> toJson() => $PostDetailsDataCommentsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}*/
