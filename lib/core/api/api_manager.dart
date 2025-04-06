import 'package:dio/dio.dart';
import 'package:eco_app/core/api/end_points.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio(

    );
    dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,

        )
    );
  }

  Future<Response> getData(
      {required String endPoint,
      Map<String, dynamic>? param,
      Map<String, dynamic>? headers}) async {
    return dio.get(EndPoints.baseURL + endPoint,
        queryParameters: param, options: Options(headers: headers));
  }

  Future<Response> postData(
      {required String endPoint,
      Map<String, dynamic>? body,
      Map<String, dynamic>? headers}) async {
    return dio.post(EndPoints.baseURL + endPoint,
        data: body, options: Options(headers: headers));
  }
  Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return dio.delete(
      EndPoints.baseURL + endPoint,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
