import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/core/utils/app_constances/app_constances.dart';
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
      dio.options.baseUrl = AppConstances.baseUrl;
      var options = Options(
        headers: withHeaders
            ? {
                if (TokenUtil.getTokenFromMemory().isNotEmpty) ...{
                  HttpHeaders.authorizationHeader:
                      TokenUtil.getTokenFromMemory()
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
