import 'package:bm_widgets/bm_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_app/feature/home/home.dart';
import 'package:klontong_app/feature/product/product.dart';
import 'package:klontong_app/utils/extension.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    super.key,
    required this.isEdit,
    required this.product,
  });

  final bool isEdit;
  final Product product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  String title = "";

  @override
  void initState() {
    title = widget.isEdit ? "Ubah" : "Tambah";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) => productListener(context, state),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                "$title Produk",
                style: BMTypography.subheading.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detail Produk",
                            style: BMTypography.bodyTextDarkGrey2,
                          ),
                          16.verticalSpace,
                          BMTextFormField(
                            initialValue: widget.product.name,
                            label: "Nama Barang",
                            onChanged: (value) {
                              widget.product.name = value;
                            },
                          ),
                          12.verticalSpace,
                          BMTextFormField(
                            initialValue: widget.product.name,
                            label: "Deskripsi Barang",
                            onChanged: (value) => setState(() {
                              widget.product.description = value;
                            }),
                          ),
                          12.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: BMTextFormField(
                                  initialValue: !widget.isEdit
                                      ? null
                                      : widget.product.price.toCurrency(),
                                  label: "Harga Satuan",
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      widget.product.price = 0;
                                    } else {
                                      String numericString = value.replaceAll(
                                        RegExp(r'[^0-9]'),
                                        '',
                                      );
                                      widget.product.price =
                                          int.tryParse(numericString) ?? 0;
                                    }
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    CurrencyInputFormatter(),
                                  ],
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: BMTextFormField(
                                  initialValue: !widget.isEdit
                                      ? null
                                      : widget.product.qty.toString(),
                                  label: "StringConstants.amount",
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      widget.product.qty = 0;
                                    } else {
                                      widget.product.qty = int.parse(value);
                                    }
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  BMButton(
                    isDisable: setDisable(),
                    text: "Simpan",
                    onTap: () => widget.isEdit ? onUpdate() : onCreate(),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return LoadingWidget(
                visible: state is CreatingProduct || state is UpdatingProduct,
              );
            },
          ),
        ],
      ),
    );
  }

  productListener(BuildContext context, ProductState state) {
    if (state is CreatedProduct) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }

    if (state is UpdatedProduct) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }
  }

  setDisable() {
    bool isDisable = widget.product.name.isEmpty ||
        widget.product.description.isEmpty ||
        widget.product.price == 0 ||
        widget.product.qty == 0;
    return isDisable;
  }

  onUpdate() {
    context.read<ProductBloc>().add(UpdateProduct(widget.product));
  }

  onCreate() {
    context.read<ProductBloc>().add(CreateProduct(widget.product));
  }
}
