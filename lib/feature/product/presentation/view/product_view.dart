import 'package:bm_widgets/bm_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_app/feature/home/home.dart';
import 'package:klontong_app/feature/product/product.dart';
import 'package:klontong_app/utils/extension.dart';
import 'package:klontong_app/utils/utils.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
    required this.isEdit,
    required this.product,
  });

  final bool isEdit;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>(),
      child: ProductWidget(isEdit: isEdit, product: product),
    );
  }
}

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.isEdit,
    required this.product,
  });

  final bool isEdit;
  final Product product;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String title = "";
  Product product = Product();

  @override
  void initState() {
    product = widget.product;
    title = widget.isEdit ? "Update" : "Create";
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
                "$title Product",
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
                            "Detail Product",
                            style: BMTypography.bodyTextDarkGrey2,
                          ),
                          16.verticalSpace,
                          BMTextFormField(
                            initialValue: product.name,
                            label: "Product Name",
                            onChanged: (value) => setState(() {
                              product.name = value;
                            }),
                          ),
                          12.verticalSpace,
                          BMTextFormField(
                            initialValue: product.name,
                            label: "Product Description",
                            onChanged: (value) => setState(() {
                              product.description = value;
                            }),
                          ),
                          12.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: BMTextFormField(
                                  initialValue: !widget.isEdit
                                      ? null
                                      : product.price.toCurrency(),
                                  label: "Product Price",
                                  onChanged: (value) => setState(() {
                                    if (value.isEmpty) {
                                      product.price = 0;
                                    } else {
                                      String numericString = value.replaceAll(
                                        RegExp(r'[^0-9]'),
                                        '',
                                      );
                                      product.price =
                                          int.tryParse(numericString) ?? 0;
                                    }
                                  }),
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
                                      : product.qty.toString(),
                                  label: "Qty",
                                  onChanged: (value) => setState(() {
                                    if (value.isEmpty) {
                                      product.qty = 0;
                                    } else {
                                      product.qty = int.parse(value);
                                    }
                                  }),
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
                    text: "Save",
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
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }

    if (state is UpdatedProduct) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    }
  }

  setDisable() {
    bool isDisable = product.name.isEmpty ||
        product.description.isEmpty ||
        product.price == 0 ||
        product.qty == 0;
    setState(() {});
    return isDisable;
  }

  onUpdate() {
    context.read<ProductBloc>().add(UpdateProduct(product));
  }

  onCreate() {
    context.read<ProductBloc>().add(CreateProduct(product));
  }
}
