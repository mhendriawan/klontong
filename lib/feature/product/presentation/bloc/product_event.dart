part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductInit extends ProductEvent {
  const ProductInit();
}

class CreateProduct extends ProductEvent {
  const CreateProduct(this.product);

  final Product product;
}

class FetchProducts extends ProductEvent {
  const FetchProducts();
}