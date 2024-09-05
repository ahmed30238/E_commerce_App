import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/consts.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_log/quick_log.dart';

class NetworkCall {
  Logger logger = const Logger("Network Logger");
  Dio dio = Dio();

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool withHeaders = true,
  }) async {
    Response? response;
    try {
      dio.options.baseUrl = Constants.apiUrl;
      var options = Options(
        headers: withHeaders
            ? {
                if (TokenUtil.getTokenFromMemory().isNotEmpty) ...{
                  "Authorization": TokenUtil.getTokenFromMemory()
                },
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
              }
            : headers,
      );
      response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      logger.error("Error Message${e.message}");
      response = e.response;
    }
    return response == null ? null : handleResponse(response);
  }

  Future<Response?> post(
    String url, {
    Map<String, dynamic>? headers,
    FormData? body,
    String? customizedToken,
    bool withHeader = true,
    encoding,
  }) async {
    if (kDebugMode) {
      log('your url is $url');
    }
    Response? response;

    dio.options.baseUrl = Constants.apiUrl;

    // (dio.httpClientAdapter as BrowserHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    var tokenFromMemory = TokenUtil.getTokenFromMemory();
    try {
      response = await dio.post(
        url,
        data: body,
        options: Options(
            headers: withHeader
                ? {
                    if (customizedToken != null) ...{
                      HttpHeaders.authorizationHeader:
                          'Bearer $customizedToken',
                    } else if (tokenFromMemory.isNotEmpty) ...{
                      HttpHeaders.authorizationHeader:
                          'Bearer $tokenFromMemory',
                    },

                    // HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.acceptHeader: 'application/json',
                    HttpHeaders.contentTypeHeader: 'application/json',
                    // HttpHeaders.acceptLanguageHeader: Get.locale?.languageCode,
                  }
                : headers,
            requestEncoder: encoding),
      );
    } on DioException catch (e) {
      log(' from post ${e.error} + message ${e.message}');
      if (e.response != null) {
        log('response : => ${e.response?.data}');
        response = e.response;
      }
    }
    return response == null ? null : handleResponse(response);
  }

  Future<Response?> handleResponse(Response response) async {
    int code = response.statusCode ?? 0;
    if (code == 200) {
      return response;
    } else {
      // todo  handle Auth;
    }
    return response;
  }
}
