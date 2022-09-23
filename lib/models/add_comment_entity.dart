import 'package:rate_my_parking/generated/json/add_comment_entity.g.dart';
import 'package:rate_my_parking/generated/json/base/json_field.dart';
import 'dart:convert';

import 'package:rate_my_parking/models/sub_models/post_comment_entity.dart';

@JsonSerializable()
class AddCommentEntity {

	PostCommentEntity? data;
	String? message;
	bool? error;

	AddCommentEntity();

  factory AddCommentEntity.fromJson(Map<String, dynamic> json) => $AddCommentEntityFromJson(json);

  Map<String, dynamic> toJson() => $AddCommentEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}