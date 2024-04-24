abstract class Storage<T> {
  Future<void> init();
  Future<List<T>> getAll();
  Future<T?> get({
    required String key,
  });
  Future<void> put({
    required String key,
    required T value,
  });
  Future<void> delete({
    required String key,
  });
  Future<void>close();
}
