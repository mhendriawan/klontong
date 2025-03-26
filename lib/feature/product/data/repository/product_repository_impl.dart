part of 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this.productDataSource);

  final ProductDataSource productDataSource;

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      Product res = await productDataSource.createProduct(product);
      return Right(res);
    } on DioException catch (e) {
      return handleDioException(e);
    } catch (e) {
      return Left(InternalErrorException());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> fetchProducts() async {
    try {
      List<Product> res = await productDataSource.fetchProducts();
      return Right(res);
    } on DioException catch (e) {
      return handleDioException(e);
    } catch (e) {
      return Left(InternalErrorException());
    }
  }

  @override
  Future<Either<Failure, String>> updateProduct(Product product) async {
    try {
      String res = await productDataSource.updateProduct(product);
      return Right(res);
    } on DioException catch (e) {
      return handleDioException(e);
    } catch (e) {
      return Left(InternalErrorException());
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String productId) async {
    try {
      String res = await productDataSource.deleteProduct(productId);
      return Right(res);
    } on DioException catch (e) {
      return handleDioException(e);
    } catch (e) {
      return Left(InternalErrorException());
    }
  }
}
