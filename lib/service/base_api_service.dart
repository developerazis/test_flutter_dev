abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(
      String url, {Map<String, dynamic>? queryParam});

  Future<dynamic> getPostApiResponse(
      String url, dynamic data, {Map<String, dynamic>? queryParam});

  Future<dynamic> getPutApiResponse(
      String url, dynamic data, {Map<String, dynamic>? queryParam});

  Future<dynamic> getDeleteApiResponse(
      String url, {Map<String, dynamic>? queryParam});

}