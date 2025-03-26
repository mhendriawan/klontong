part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductFailed extends ProductState {
  const ProductFailed(this.title, this.description);

  final String title;
  final String description;
}

final class ProductInternalError extends ProductState {
  const ProductInternalError();
}

final class CreatingProduct extends ProductState {
  const CreatingProduct();
}

final class CreatedProduct extends ProductState {
  const CreatedProduct();
}

final class FetchingProducts extends ProductState {
  const FetchingProducts();
}

final class FetchedProducts extends ProductState {
  const FetchedProducts(this.products);

  final List<Product> products;
}

final class UpdatingProduct extends ProductState {
  const UpdatingProduct();
}

final class UpdatedProduct extends ProductState {
  const UpdatedProduct();
}

final class DeletingProduct extends ProductState {
  const DeletingProduct();
}

final class DeletedProduct extends ProductState {
  const DeletedProduct();
}