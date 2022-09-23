import 'package:rate_my_parking/generated/json/base/json_convert_content.dart';
import 'package:rate_my_parking/models/sub_models/post_comment_entity.dart';

import '../../models/add_comment_entity.dart';

AddCommentEntity $AddCommentEntityFromJson(Map<String, dynamic> json) {
	final AddCommentEntity addCommentEntity = AddCommentEntity();
	final PostCommentEntity? data = jsonConvert.convert<PostCommentEntity>(json['data']);
	if (data != null) {
		addCommentEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		addCommentEntity.message = message;
	}
	final bool? error = jsonConvert.convert<bool>(json['error']);
	if (error != null) {
		addCommentEntity.error = error;
	}
	return addCommentEntity;
}

Map<String, dynamic> $AddCommentEntityToJson(AddCommentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	data['error'] = entity.error;
	return data;
}