class LocalStorage {
  const LocalStorage();

  Future<void> write(String key, String value) async {
    throw UnimplementedError('Connect persistent local storage here.');
  }

  Future<String?> read(String key) async {
    throw UnimplementedError('Connect persistent local storage here.');
  }
}
