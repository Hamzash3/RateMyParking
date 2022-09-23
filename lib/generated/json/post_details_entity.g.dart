import 'package:rate_my_parking/generated/json/base/json_convert_content.dart';
import 'package:rate_my_parking/models/post_details_entity.dart';

import '../../models/sub_models/post_comment_entity.dart';

PostDetailsEntity $PostDetailsEntityFromJson(Map<String, dynamic> json) {
	final PostDetailsEntity postDetailsEntity = PostDetailsEntity();
	final PostDetailsData? data = jsonConvert.convert<PostDetailsData>(json['data']);
	if (data != null) {
		postDetailsEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		postDetailsEntity.message = message;
	}
	final bool? error = jsonConvert.convert<bool>(json['error']);
	if (error != null) {
		postDetailsEntity.error = error;
	}
	return postDetailsEntity;
}

Map<String, dynamic> $PostDetailsEntityToJson(PostDetailsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	data['error'] = entity.error;
	return data;
}

PostDetailsData $PostDetailsDataFromJson(Map<String, dynamic> json) {
	final PostDetailsData postDetailsData = PostDetailsData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		postDetailsData.id = id;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		postDetailsData.image = image;
	}
	final String? licenseId = jsonConvert.convert<String>(json['license_id']);
	if (licenseId != null) {
		postDetailsData.licenseId = licenseId;
	}
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		postDetailsData.latitude = latitude;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		postDetailsData.longitude = longitude;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		postDetailsData.address = address;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		postDetailsData.description = description;
	}
	final double? rating = jsonConvert.convert<double>(json['rating']);
	if (rating != null) {
		postDetailsData.rating = rating;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		postDetailsData.userId = userId;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		postDetailsData.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		postDetailsData.updatedAt = updatedAt;
	}
	final List<PostCommentEntity>? comments = jsonConvert.convertListNotNull<PostCommentEntity>(json['comments']);
	if (comments != null) {
		postDetailsData.comments = comments;
	}
	return postDetailsData;
}

Map<String, dynamic> $PostDetailsDataToJson(PostDetailsData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['image'] = entity.image;
	data['license_id'] = entity.licenseId;
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['address'] = entity.address;
	data['description'] = entity.description;
	data['rating'] = entity.rating;
	data['user_id'] = entity.userId;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['comments'] =  entity.comments?.map((v) => v.toJson()).toList();
	return data;
}

/*PostCommentEntity $PostDetailsDataCommentsFromJson(Map<String, dynamic> json) {
	final PostCommentEntity postDetailsDataComments = PostCommentEntity();
	final int? postId = jsonConvert.convert<int>(json['post_id']);
	if (postId != null) {
		postDetailsDataComments.postId = postId;
	}
	final String? comment = jsonConvert.convert<String>(json['comment']);
	if (comment != null) {
		postDetailsDataComments.comment = comment;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		postDetailsDataComments.createdAt = createdAt;
	}
	return postDetailsDataComments;
}*/
/*

Map<String, dynamic> $PostDetailsDataCommentsToJson(PostCommentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['post_id'] = entity.postId;
	data['comment'] = entity.comment;
	data['created_at'] = entity.createdAt;
	return data;
}*/
