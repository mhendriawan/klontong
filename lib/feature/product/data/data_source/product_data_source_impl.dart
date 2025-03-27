part of 'product_data_source.dart';

class ProductDataSourceImpl implements ProductDataSource {
  ProductDataSourceImpl(this.dio, this.urlConstant);

  final Dio dio;
  final UrlConstant urlConstant;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  @override
  Future<Product> createProduct(Product product) async {
    Response<dynamic> response = await dio.post(
      urlConstant.product,
      data: product,
      options: Options(headers: headers),
    );
    return Product.fromJson(response.data);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    Response<dynamic> response = await dio.get(
      urlConstant.product,
      options: Options(headers: headers),
    );
    List<Product> products = [];
    if (response.data.isEmpty) {
      return products;
    }
    for (int i = 0; i < response.data.length; i++) {
      products.add(Product.fromJson(response.data[i]));
    }

    return products;
  }

  @override
  Future<String> updateProduct(Product product) async {
    Response<dynamic> response = await dio.put(
      "${urlConstant.product}/${product.id}",
      data: product,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<String> deleteProduct(String productId) async {
    Response<dynamic> response = await dio.delete(
      "${urlConstant.product}/$productId",
      options: Options(headers: headers),
    );
    return response.data;
  }
}
