import 'package:bm_widgets/bm_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klontong_app/feature/product/product.dart';
import 'package:klontong_app/utils/extension.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: BMPalette.grey1,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: BMTypography.captionDarkGrey),
          Text(product.description, style: BMTypography.bodyTextBlack2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.price.toCurrency(),
                style: BMTypography.bodyTextRed2,
              ),
              16.horizontalSpace,
              Text(
                "Qty: ${product.qty}",
                style: BMTypography.captionDarkGrey,
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BMButtonSecondary(
                text: 'Update',
                onTap: () => onTapUpdate(context),
              ),
              8.horizontalSpace,
              BMButtonSecondary(
                text: 'Delete',
                onTap: () => onTapDelete(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onTapUpdate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductView(
          isEdit: true,
          product: product,
        ),
      ),
    );
  }

  onTapDelete(BuildContext context) {
    context.read<ProductBloc>().add(DeleteProduct(product.id));
  }
}
