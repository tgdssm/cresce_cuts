import 'dart:convert';

import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/storage/storage.dart';
import 'package:vale_vantagens/modules/discounts/data/datasources/discounts_datasource.dart';

class DiscountsDatasourceImpl implements DiscountsDatasource {
  final Storage<String> storage;
  const DiscountsDatasourceImpl(this.storage);
  @override
  Future<List<DiscountModel>> getDiscounts() async {
    try {
      await storage.init();
      final result = await storage.getAll();
      await storage.close();
      return result
          .map<DiscountModel>(
            (e) => DiscountModel.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
    } on BaseError catch (_) {
      rethrow;
    } catch (e) {
      throw BaseError('Error getting discounts. Try again later.');
    }
  }
}
