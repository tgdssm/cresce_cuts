import 'package:flutter/material.dart';
import 'package:vale_vantagens/core/utils/text_styles.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';

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
      height: 240.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: AppColors.silver),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Descrição',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 70.0,
                        child: Text(
                          product.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: TextStyles.smallRegular,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Preço',
                                style: TextStyles.smallMedium,
                              ),
                              Text(
                                'R\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: TextStyles.smallRegular,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Categoria',
                                style: TextStyles.smallMedium,
                              ),
                              Text(
                                product.category,
                                style: TextStyles.smallRegular,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            alignment: Alignment.center,
            height: 40.0,
            child: InkWell(
              onTap: () {},
              child: const Text(
                'Adicionar desconto',
                style: TextStyles.smallMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
