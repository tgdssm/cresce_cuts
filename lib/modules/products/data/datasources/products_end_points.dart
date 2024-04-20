enum ProductsEndPoints {
  getProducts('https://fakestoreapi.com/products');

  final String url;

  const ProductsEndPoints(this.url);
}
