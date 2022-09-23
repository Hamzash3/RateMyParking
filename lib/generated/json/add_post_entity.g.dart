import 'package:rate_my_parking/generated/json/base/json_convert_content.dart';
import 'package:rate_my_parking/models/add_post_entity.dart';

AddPostEntity $AddPostEntityFromJson(Map<String, dynamic> json) {
	final AddPostEntity addPostEntity = AddPostEntity();
	final AddPostData? data = jsonConvert.convert<AddPostData>(json['data']);
	if (data != null) {
		addPostEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		addPostEntity.message = message;
	}
	final bool? error = jsonConvert.convert<bool>(json['error']);
	if (error != null) {
		addPostEntity.error = error;
	}
	return addPostEntity;
}

Map<String, dynamic> $AddPostEntityToJson(AddPostEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] = entity.data?.toJson();
	data['message'] = entity.message;
	data['error'] = entity.error;
	return data;
}

AddPostData $AddPostDataFromJson(Map<String, dynamic> json) {
	final AddPostData addPostData = AddPostData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		addPostData.id = id;
	}
	final String? image = jsonConvert.convert<String>(json['image']);
	if (image != null) {
		addPostData.image = image;
	}
	final String? licenseId = jsonConvert.convert<String>(json['license_id']);
	if (licenseId != null) {
		addPostData.licenseId = licenseId;
	}
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		addPostData.latitude = latitude;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		addPostData.longitude = longitude;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		addPostData.address = address;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		addPostData.description = description;
	}
	final int? rating = jsonConvert.convert<int>(json['rating']);
	if (rating != null) {
		addPostData.rating = rating;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		addPostData.userId = userId;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		addPostData.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		addPostData.updatedAt = updatedAt;
	}
	return addPostData;
}

Map<String, dynamic> $AddPostDataToJson(AddPostData entity) {
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
	return data;
}