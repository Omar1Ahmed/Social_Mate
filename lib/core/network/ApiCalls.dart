abstract class ApiCalls {
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? Headers, });
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body);
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body);
  Future<Map<String, dynamic>> delete(String endpoint);
}