import 'package:bm_widgets/bm_widgets.dart';
import 'package:flutter/material.dart';
import 'package:klontong_app/feature/product/product.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BMPalette.white,
      appBar: AppBar(
        backgroundColor: BMPalette.white,
        title: Text(
          "Produk",
          style: BMTypography.subheading.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: const ProductsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(context),
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductView(
          isEdit: false,
          product: Product(),
        ),
      ),
    );
  }
}
