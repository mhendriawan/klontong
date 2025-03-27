import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:klontong_app/feature/product/product.dart';

final sl = GetIt.instance;

Future<void> setupInjection() async {
  sl.registerLazySingleton<Dio>(
    () {
      final dio = Dio();
      return dio;
    },
  );

  //product
  sl.registerFactory(
    () => ProductBloc(sl()),
  );
  sl.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
}
