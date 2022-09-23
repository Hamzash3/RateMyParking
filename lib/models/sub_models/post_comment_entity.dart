import 'package:rate_my_parking/generated/json/base/json_field.dart';
import 'package:rate_my_parking/generated/json/post_comment_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class PostCommentEntity {

	@JSONField(name: "post_id")
	int? postId;
	String? comment;
	@JSONField(name: "created_at")
	String? createdAt;
  
  PostCommentEntity();

  factory PostCommentEntity.fromJson(Map<String, dynamic> json) => $PostCommentEntityFromJson(json);

  Map<String, dynamic> toJson() => $PostCommentEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}