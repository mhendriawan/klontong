import 'package:dio/dio.dart';
import 'package:klontong_app/constants/constants.dart';
import 'package:klontong_app/feature/product/product.dart';

part 'product_data_source_impl.dart';

abstract class ProductDataSource {
  Future<Product> createProduct(Product product);

  Future<List<Product>> fetchProducts();

  Future<String> updateProduct(Product product);

  Future<String> deleteProduct(String productId);
}
