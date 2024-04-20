import 'package:vale_vantagens/modules/products/data/models/models.dart';

abstract class ProductsDatasource {
  Future<List<ProductModel>> getProducts();
}