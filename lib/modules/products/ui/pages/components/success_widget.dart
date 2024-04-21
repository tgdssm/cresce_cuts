import 'package:flutter/material.dart';
import 'package:vale_vantagens/modules/products/ui/pages/components/product_card_widget.dart';

import '../../../domain/entities/product_entity.dart';

class SuccessWidget extends StatelessWidget {
  final List<ProductEntity> products;
  const SuccessWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardWidget(
          product: products[index],
        );
      },
    );
  }
}
