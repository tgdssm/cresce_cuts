import 'package:hive/hive.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/storage/hive_storage_impl.dart';
import 'package:vale_vantagens/core/storage/storage.dart';
import 'package:vale_vantagens/modules/register_discount/data/datasources/register_discount_datasource.dart';

class RegisterDiscountDatasourceImpl implements RegisterDiscountDatasource {
  final Storage<DiscountModel> storage =
      const HiveStorageImpl<DiscountModel>(boxName: 'discounts');
  @override
  Future<void> register(DiscountModel discount) async {
    await storage.init();
    await storage.put(
      key: discount.id.toString(),
      value: discount,
    );
  }
}
