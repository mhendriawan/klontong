part of 'product_data_source.dart';

class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl(this.dio);

  final Dio dio;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  @override
  Future<Product> createProduct(Product product) async {
    Response<dynamic> response = await dio.post(
      UrlConstant.product,
      data: product,
      options: Options(headers: headers),
    );
    return Product.fromJson(response.data);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    Response<dynamic> response = await dio.get(
      UrlConstant.product,
      options: Options(headers: headers),
    );
    return productFromJson(response.data);
  }

  @override
  Future<Product> updateProduct(Product product) async {
    Response<dynamic> response = await dio.put(
      "${UrlConstant.product}/${product.id}",
      data: product,
      options: Options(headers: headers),
    );
    return Product.fromJson(response.data);
  }

  @override
  Future<Product> deleteProduct(String productId) async {
    Response<dynamic> response = await dio.delete(
      "${UrlConstant.product}/$productId",
      options: Options(headers: headers),
    );
    return Product.fromJson(response.data);
  }
}
