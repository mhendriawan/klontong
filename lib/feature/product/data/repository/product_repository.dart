import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:klontong_app/feature/product/product.dart';
import 'package:klontong_app/utils/utils.dart';

part 'product_repository_impl.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> createProduct(Product product);

  Future<Either<Failure, List<Product>>> fetchProducts();

  Future<Either<Failure, String>> updateProduct(Product product);

  Future<Either<Failure, Product>> deleteProduct(String productId);
}
