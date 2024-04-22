import 'package:vale_vantagens/commons/models/models.dart';

abstract class ProductsDatasource {
  Future<List<ProductModel>> getProducts();
}