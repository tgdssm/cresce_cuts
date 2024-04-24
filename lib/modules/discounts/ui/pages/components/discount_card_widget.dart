import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/commons/commons.dart';
import 'package:vale_vantagens/core/utils/text_styles.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/discount_detail/discount_detail_module.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/components/tile_date_discount_widget.dart';

import '../../../../../core/utils/app_colors.dart';

class DiscountCardWidget extends StatelessWidget {
  final DiscountEntity discount;
  const DiscountCardWidget({
    super.key,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: AppColors.silver),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
            ),
            alignment: Alignment.centerRight,
            child: DefaultSwitch(
              onChanged: (value) {},
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Row(
                children: [
                  Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.silver),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.none,
                      child: Image.network(
                        discount.image,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          discount.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: TextStyles.smallRegular,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Desconto: ',
                              style: TextStyles.smallMedium,
                            ),
                            Expanded(
                              child: Text(
                                discount.discountType.name,
                                style: TextStyles.smallRegular,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TileDateDiscountWidget(
                    title: 'Data ativação',
                    date: discount.activationDate,
                  ),
                ),
                Expanded(
                  child: TileDateDiscountWidget(
                    title: 'Data inativação',
                    date: discount.inactivationDate!,
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
              onTap: () {
                Modular.to.pushNamed(
                  DiscountDetailModule.initial.completePath,
                  arguments: discount,
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ver desconto',
                    style: TextStyles.smallMedium,
                  ),
                  SizedBox(width: 5.0,),
                  Icon(Icons.remove_red_eye_outlined)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
