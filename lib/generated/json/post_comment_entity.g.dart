import 'package:rate_my_parking/generated/json/base/json_convert_content.dart';
import 'package:rate_my_parking/models/sub_models/post_comment_entity.dart';

PostCommentEntity $PostCommentEntityFromJson(Map<String, dynamic> json) {
	final PostCommentEntity postCommentEntity = PostCommentEntity();
	final int? postId = jsonConvert.convert<int>(json['post_id']);
	if (postId != null) {
		postCommentEntity.postId = postId;
	}
	final String? comment = jsonConvert.convert<String>(json['comment']);
	if (comment != null) {
		postCommentEntity.comment = comment;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		postCommentEntity.createdAt = createdAt;
	}
	return postCommentEntity;
}

Map<String, dynamic> $PostCommentEntityToJson(PostCommentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['post_id'] = entity.postId;
	data['comment'] = entity.comment;
	data['created_at'] = entity.createdAt;
	return data;
}