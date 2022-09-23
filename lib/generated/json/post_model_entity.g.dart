import 'package:rate_my_parking/generated/json/base/json_convert_content.dart';
import 'package:rate_my_parking/models/post_model_entity.dart';

PostModelEntity $PostModelEntityFromJson(Map<String, dynamic> json) {
	final PostModelEntity postModelEntity = PostModelEntity();
	final List<PostModelData>? data = jsonConvert.convertListNotNull<PostModelData>(json['data']);
	if (data != null) {
		postModelEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		postModelEntity.message = message;
	}
	final bool? error = jsonConvert.convert<bool>(json['error']);
	if (error != null) {
		postModelEntity.error = error;
	}
	return postModelEntity;
}

Map<String, dynamic> $PostModelEntityToJson(PostModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data?.map((v) => v.toJson()).toList();
	data['message'] = entity.message;
	data['error'] = entity.error;
	return data;
}

PostModelData $PostModelDataFromJson(Map<String, dynamic> json) {
	final PostModelData postModelData = PostModelData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		postModelData.id = id;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		postModelData.image = image;
	}
	final String? licenseId = jsonConvert.convert<String>(json['license_id']);
	if (licenseId != null) {
		postModelData.licenseId = licenseId;
	}
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		postModelData.latitude = latitude;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		postModelData.longitude = longitude;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		postModelData.address = address;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		postModelData.description = description;
	}
	final double? rating = jsonConvert.convert<double>(json['rating']);
	if (rating != null) {
		postModelData.rating = rating;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		postModelData.userId = userId;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		postModelData.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		postModelData.updatedAt = updatedAt;
	}
	final int? commentsCount = jsonConvert.convert<int>(json['comments_count']);
	if (commentsCount != null) {
		postModelData.commentsCount = commentsCount;
	}
	return postModelData;
}

Map<String, dynamic> $PostModelDataToJson(PostModelData entity) {
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
	data['comments_count'] = entity.commentsCount;
	return data;
}