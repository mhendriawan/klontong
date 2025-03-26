import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/feature/product/product.dart';
import 'package:klontong_app/utils/utils.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  void onFailure(Failure failure, Emitter<ProductState> emit) {
    if (failure is ServerFailure) {
      emit(ProductFailed(failure.title, failure.description));
    } else {
      emit(const ProductInternalError());
    }
  }

  ProductBloc(this.productRepository) : super(const ProductInitial()) {
    on<CreateProduct>((event, emit) async {
      emit(const CreatingProduct());

      var response = await productRepository.createProduct(event.product);
      response.fold(
        (failure) => onFailure(failure, emit),
        (response) {
          emit(const CreatedProduct());
        },
      );
    });

    on<FetchProducts>((event, emit) async {
      emit(const FetchingProducts());

      var response = await productRepository.fetchProducts();
      response.fold(
        (failure) => onFailure(failure, emit),
        (response) {
          emit(FetchedProducts(response));
        },
      );
    });

    on<UpdateProduct>((event, emit) async {
      emit(const UpdatingProduct());

      var response = await productRepository.updateProduct(event.product);
      response.fold(
        (failure) => onFailure(failure, emit),
        (response) {
          emit(const UpdatedProduct());
        },
      );
    });
  }
}
