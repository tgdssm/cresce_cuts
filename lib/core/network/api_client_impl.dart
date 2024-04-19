import 'package:dio/dio.dart';
import 'package:vale_vantagens/core/network/api_client.dart';

class ApiClientImpl implements ApiClient {
  final Dio _dio;

  ApiClientImpl(this._dio);

  @override
  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _dio.delete(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) {
    return _dio.post(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        contentType: contentType,
      ),
    );
  }

  @override
  Future<dynamic> put(
    String url,
    Map<String, dynamic>? body, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) {
    return _dio.put(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
        contentType: contentType,
      ),
    );
  }
}
