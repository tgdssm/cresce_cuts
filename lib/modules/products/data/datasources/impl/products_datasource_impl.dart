import 'package:dio/dio.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/network/api_client.dart';
import 'package:vale_vantagens/modules/products/data/datasources/products_datasource.dart';
import 'package:vale_vantagens/modules/products/data/datasources/products_end_points.dart';
import 'package:vale_vantagens/modules/products/data/models/product_model.dart';

class ProductsDatasourceImpl implements ProductsDatasource {
  final ApiClient client;

  const ProductsDatasourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final List<ProductModel> products = [];
      final response = await client.get(ProductsEndPointApi.getProducts.url);
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      return products;
    } on DioException catch (e) {
      throw BaseError(e.message, e.response?.statusCode);
    } catch (e) {
      throw BaseError('Something went wrong. Try again later.');
    }
  }
}
