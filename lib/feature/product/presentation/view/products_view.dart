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
  List<Product> products = [
    Product(
      name: "Ciki",
      description: "Ciki ciki yang super enak, hanya di toko klontong kami",
      price: 100000,
      qty: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) => productListener(context, state),
      builder: (context, state) {
        return Stack(
          children: [
            ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return CardProduct(product: product);
              },
            ),
            LoadingWidget(visible: state is FetchingProducts),
          ],
        );
      },
    );
  }

  productListener(BuildContext context, ProductState state) {
    if (state is FetchedProducts) {
      products = state.products;
    }
  }
}
