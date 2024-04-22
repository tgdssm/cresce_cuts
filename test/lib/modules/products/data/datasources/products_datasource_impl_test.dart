import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vale_vantagens/core/errors/base_error.dart';
import 'package:vale_vantagens/core/network/api_client.dart';
import 'package:vale_vantagens/modules/products/data/datasources/impl/products_datasource_impl.dart';
import 'package:vale_vantagens/modules/products/data/datasources/products_datasource.dart';
import 'package:vale_vantagens/commons/models/models.dart';

const payload = <Map<String, dynamic>>[
  {
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description":
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "rating": {"rate": 3.9, "count": 120}
  },
  {
    "id": 2,
    "title": "Mens Casual Premium Slim Fit T-Shirts ",
    "price": 22.3,
    "description":
        "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
    "category": "men's clothing",
    "image":
        "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "rating": {"rate": 4.1, "count": 259}
  },
];

class ApiClientMock extends Mock implements ApiClient {}

void main() {
  late final ApiClient apiClient;
  late final ProductsDatasource datasource;

  setUpAll(() {
    apiClient = ApiClientMock();
    datasource = ProductsDatasourceImpl(apiClient);
  });

  group('test get products', () {
    test('success', () async {
      when(() => apiClient.get(
            any(),
          )).thenAnswer((_) async => Response<dynamic>(
            data: payload,
            statusCode: 200,
            requestOptions: RequestOptions(),
          ));

      final result = await datasource.getProducts();
      expect(result, isA<List<ProductModel>>());
      expect(result.length, equals(2));
      expect(result.first.id, equals(1));
      expect(result.last.id, equals(2));
    });

    test('exception', () async {
      when(() => apiClient.get(
            any(),
          )).thenThrow(
        (_) async => DioException(
          message: 'Error',
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(),
          ),
          requestOptions: RequestOptions(),
        ),
      );

      final result = datasource.getProducts();
      expect(result, throwsA(isA<BaseError>()));
    });
  });
}
