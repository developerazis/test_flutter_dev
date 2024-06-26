import 'package:test_maha_dev/service/network_service.dart';

import '../app_url.dart';
import '../model/user_response_model.dart';

class MaterialRepository {
  final NetworkApiService _service = NetworkApiService();

  Future<UserResponse?> getUser({int page = 1 , int limit = 4}) async {
    try {
      Map<String, dynamic> queryParameter = {
        "page": page
      };
      dynamic response = await _service.getGetApiResponse(AppUrl.getUsers, queryParam: queryParameter);

      if (response is Map<String, dynamic>) {
        return UserResponse.fromJson(response);
      }

      return null;

    } catch (e) {
      rethrow;
    }
  }

  Future<User?> createUser({required String name, required String job}) async {
    try {
      Map<String, dynamic> data = {
        "name" : name,
        "job" : job
      };
      dynamic response = await _service.getPostApiResponse(AppUrl.createUser, data);

      if (response is Map<String, dynamic>) {
        return User.fromJson(response);
      }

      return null;

    } catch (e) {
      rethrow;
    }
  }

  Future<User?> updateUser({required String name, required String job, required String id}) async {
    try {
      Map<String, dynamic> data = {
        "name" : name,
        "job" : job
      };
      String url = AppUrl.updateUser(id);
      dynamic response = await _service.getPutApiResponse(url, data);

      if (response is Map<String, dynamic>) {
        return User.fromJson(response);
      }

      return null;

    } catch (e) {
      rethrow;
    }
  }

  Future<User?> deleteUser({required String id}) async {
    try {
      String url = AppUrl.updateUser(id);
      dynamic response = await _service.getDeleteApiResponse(url);

      if (response is Map<String, dynamic>) {
        return User.fromJson(response);
      }

      return null;

    } catch (e) {
      rethrow;
    }
  }
}