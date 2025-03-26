import 'package:bm_widgets/bm_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong_app/utils/utils.dart';
import 'package:klontong_app/feature/product/product.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>()..add(const FetchProducts()),
      child: const ProductsWidget(),
    );
  }
}

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({super.key});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) => productListener(context, state),
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CardProduct(product: product),
                  );
                },
              ),
            ),
            LoadingWidget(
              visible: state is FetchingProducts || state is DeletingProduct,
            ),
          ],
        );
      },
    );
  }

  productListener(BuildContext context, ProductState state) {
    if (state is FetchedProducts) {
      products = state.products;
    }

    if (state is DeletedProduct) {
      context.read<ProductBloc>().add(const FetchProducts());
    }
  }
}
