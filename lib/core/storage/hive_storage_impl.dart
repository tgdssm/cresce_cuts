import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/storage/storage.dart';

class HiveStorageImpl<T> implements Storage<T> {
  final String boxName;
  const HiveStorageImpl({required this.boxName});

  @override
  Future<void> delete({
    required String key,
  }) async {
    try {
      final box = Hive.box<T>(boxName);
      box.delete(key);
    } on HiveError catch (e) {
      throw BaseError(e.message);
    } catch (_) {
      throw BaseError('Error when deleting');
    }
  }

  @override
  Future<T?> get({
    required String key,
  }) async {
    try {
      final box = Hive.box<T>(boxName);
      return box.get(key);
    } on HiveError catch (e) {
      throw BaseError(e.message);
    } catch (_) {
      throw BaseError('Error when picking up');
    }
  }

  @override
  Future<List<T>> getAll() async {
    try {
      final box = Hive.box<T>(boxName);
      return box.values.toList();
    } on HiveError catch (e) {
      throw BaseError(e.message);
    } catch (_) {
      throw BaseError('Error when getting all');
    }
  }

  @override
  Future<void> put({
    required String key,
    required T value,
  }) async {
    try {
      final box = Hive.box<T>(boxName);
      box.put(key, value);
    } on HiveError catch (e) {
      throw BaseError(e.message);
    } catch (e) {
      throw BaseError('Error when put');
    }
  }

  @override
  Future<void> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox<T>(boxName);
      }
    } on HiveError catch (e) {
      throw BaseError(e.message);
    } catch (_) {
      throw BaseError('Error when opening box');
    }
  }

  @override
  Future<void> close() async {
    try {
      await Hive.close();
    } on HiveError catch (e) {
      throw BaseError(e.message);
    } catch (_) {
      throw BaseError('Error when closing box');
    }
  }
}
