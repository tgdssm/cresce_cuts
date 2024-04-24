import 'package:vale_vantagens/commons/models/discount_model.dart';

abstract class DiscountsDatasource {
  Future<List<DiscountModel>> getDiscounts();
}