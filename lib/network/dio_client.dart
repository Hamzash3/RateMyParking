
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rate_my_parking/helpers/session.dart';
import 'package:rate_my_parking/helpers/view_utils.dart';
import 'package:rate_my_parking/models/add_post_entity.dart';
import 'package:rate_my_parking/models/post_details_entity.dart';
import 'package:rate_my_parking/models/user_account_entity.dart';

import '../models/add_comment_entity.dart';
import '../models/post_model_entity.dart';
import 'dio_exception.dart';

class DioClient {


  final String _addPost = "/api/create-post";
  final String _signUp = "/api/signup";
  final String _login = "/api/login";
  final String _getPostsByLicenseId = "/api/get-post-by-license-id";
  final String _getPostDetails = "/api/get-post-detail";
  final String _writeComment = "/api/write-comment";

  DioClient()
      : _dio = Dio(
    BaseOptions(
      baseUrl: ViewUtils.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 8000,
      responseType: ResponseType.json,
    ),
  );

  late final Dio _dio;


  Future<AddPostEntity?> addPost(Map<String,dynamic> queryParameters,String imagePath) async {
    try {
      final token = await Session().getAuthToken();
      _dio.options.headers["Authorization"] = token;
      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imagePath,
          filename: DateTime.now().toIso8601String(),
        ),
      });
      final response = await _dio.post(_addPost,queryParameters: queryParameters,data: data);
      return AddPostEntity.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.toString();
    }
  }

  Future<PostModelEntity?> getPostsByLicenseId(Map<String,dynamic> queryParameters) async {
    try {
      final response = await _dio.post(_getPostsByLicenseId,queryParameters: queryParameters);
      return PostModelEntity.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.toString();
    }
  }

  Future<AddCommentEntity?> writeComment(Map<String,dynamic> queryParameters) async {
    try {
      final token = await Session().getAuthToken();
      _dio.options.headers["Authorization"] = token;
      final response = await _dio.post(_writeComment,queryParameters: queryParameters);
      return AddCommentEntity.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.toString();
    }
  }

  Future<PostDetailsEntity?> getPostDetail(Map<String,dynamic> queryParameters) async {
    try {
      final response = await _dio.post(_getPostDetails,queryParameters: queryParameters);
      return PostDetailsEntity.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.toString();
    }
  }

  Future<UserAccountEntity?> signUp(Map<String,dynamic> queryParameters) async {
    try {
      final response = await _dio.post(_signUp,queryParameters: queryParameters);
      return UserAccountEntity.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.toString();
    }
  }

  Future<UserAccountEntity?> login(Map<String,dynamic> queryParameters) async {
    try {
      final response = await _dio.post(_login,queryParameters: queryParameters);
      return UserAccountEntity.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.toString();
    }
  }
}