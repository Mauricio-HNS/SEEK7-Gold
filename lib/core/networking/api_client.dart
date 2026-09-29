class ApiClient {
  const ApiClient();

  Future<Map<String, dynamic>> get(String path) async {
    throw UnimplementedError('Connect the SEEK7 backend here: GET $path');
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    throw UnimplementedError('Connect the SEEK7 backend here: POST $path');
  }
}
