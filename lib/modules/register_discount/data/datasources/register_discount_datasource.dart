import 'package:vale_vantagens/commons/models/discount_model.dart';

abstract class RegisterDiscountDatasource {
  Future<void> register(DiscountModel discount);
}