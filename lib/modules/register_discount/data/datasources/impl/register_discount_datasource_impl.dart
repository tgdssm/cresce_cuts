import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/storage/storage.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/register_discount_datasource.dart';

class RegisterDiscountDatasourceImpl implements RegisterDiscountDatasource {
  final Storage<DiscountModel> storage;
  const RegisterDiscountDatasourceImpl(this.storage);
  @override
  Future<void> register(DiscountModel discount) async {
    try {
      await storage.init();
      await storage.put(
        key: discount.id.toString(),
        value: discount,
      );
      return;
    } on BaseError catch (_) {
      rethrow;
    } catch (e) {
      throw BaseError('Error saving discount. Try again later.');
    }
  }
}
