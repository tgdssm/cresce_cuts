abstract class ApiClient {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  });

  Future<dynamic> put(
    String url,
    Map<String, dynamic>? body, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  });

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}
