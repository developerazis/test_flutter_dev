import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'base_api_service.dart';

class NetworkApiService extends BaseApiServices {
  late Dio _dio;

  NetworkApiService(){
    _dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 40),
        contentType: "application/json"
    ));
    initInterceptors();
  }

  @override
  Future getGetApiResponse(String url, {Map<String, dynamic>? queryParam}) async {
    dynamic responseJson;
    try {
      Response response = await _dio.get(url, queryParameters: queryParam);
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data, {Map<String, dynamic>? queryParam}) async {
    dynamic responseJson;
    try {
      Response response = await _dio.post(url, data: data, queryParameters: queryParam);
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 201:
        dynamic responseJson = response.data;
        return responseJson;
      case 204:
        dynamic responseJson = response.data;
        return responseJson;
      default:
        throw Exception(
            "Error accourded while communicating with server with status code ${response.statusCode}");
    }
  }

  void initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          requestOptions.headers.addAll(_dio.options.headers);
          if (kDebugMode) {
            print(
                "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
                    "=> REQUEST VALUES: ${requestOptions.queryParameters} "
                    "=> HEADERS: ${requestOptions.headers}"
                    " => CONTENT TYPE: ${requestOptions.contentType}");
          }
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print("RESPONSE[${response.statusCode}] PATH[${response.requestOptions.path}] => DATA: ${response.data}");
          }
          return handler.next(response);
        },
        onError: (err, handler) {
          if (kDebugMode) {
            print("Error[${err.message}] PATH[${err.requestOptions.path}]");
          }
          return handler.next(err);
        },
      ),
    );
  }

  @override
  Future getDeleteApiResponse(String url,{Map<String, dynamic>? queryParam}) async {
    dynamic responseJson;
    try {
      Response response = await _dio.delete(url, queryParameters: queryParam);
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, data, {Map<String, dynamic>? queryParam}) async {
    dynamic responseJson;
    try {
      Response response = await _dio.put(url, data: data, queryParameters: queryParam);
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
    return responseJson;
  }
}