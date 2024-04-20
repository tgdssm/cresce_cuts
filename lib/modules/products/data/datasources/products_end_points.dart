enum ProductsEndPointApi {
  getProducts('https://fakestoreapi.com/products');

  final String url;

  const ProductsEndPointApi(this.url);
}
