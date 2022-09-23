import 'package:rate_my_parking/generated/json/base/json_convert_content.dart';
import 'package:rate_my_parking/models/user_account_entity.dart';

UserAccountEntity $UserAccountEntityFromJson(Map<String, dynamic> json) {
	final UserAccountEntity userAccountEntity = UserAccountEntity();
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		userAccountEntity.message = message;
	}
	final UserAccountData? data = jsonConvert.convert<UserAccountData>(json['data']);
	if (data != null) {
		userAccountEntity.data = data;
	}
	final bool? error = jsonConvert.convert<bool>(json['error']);
	if (error != null) {
		userAccountEntity.error = error;
	}
	return userAccountEntity;
}

Map<String, dynamic> $UserAccountEntityToJson(UserAccountEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['message'] = entity.message;
	data['data'] = entity.data?.toJson();
	data['error'] = entity.error;
	return data;
}

UserAccountData $UserAccountDataFromJson(Map<String, dynamic> json) {
	final UserAccountData userAccountData = UserAccountData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		userAccountData.id = id;
	}
	final String? licenseId = jsonConvert.convert<String>(json['license_id']);
	if (licenseId != null) {
		userAccountData.licenseId = licenseId;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		userAccountData.email = email;
	}
	final dynamic? address = jsonConvert.convert<dynamic>(json['address']);
	if (address != null) {
		userAccountData.address = address;
	}
	final String? accessToken = jsonConvert.convert<String>(json['access_token']);
	if (accessToken != null) {
		userAccountData.accessToken = accessToken;
	}
	return userAccountData;
}

Map<String, dynamic> $UserAccountDataToJson(UserAccountData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['license_id'] = entity.licenseId;
	data['email'] = entity.email;
	data['address'] = entity.address;
	data['access_token'] = entity.accessToken;
	return data;
}