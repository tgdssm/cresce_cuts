import 'package:flutter/material.dart';
import 'package:vale_vantagens/modules/products/domain/entities/entities.dart';

import '../../../../../core/utils/app_colors.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: AppColors.silver,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      height: 30.0,
                      width: 270.0,
                      decoration: BoxDecoration(
                        color: AppColors.silver,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    height: 30.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: AppColors.silver,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Column(
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    height: 30.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: AppColors.silver,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
