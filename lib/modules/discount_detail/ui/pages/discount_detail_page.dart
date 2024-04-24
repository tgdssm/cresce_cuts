import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:vale_vantagens/commons/commons.dart';
import 'package:vale_vantagens/commons/entities/discount_entity.dart';
import 'package:vale_vantagens/commons/models/discount_model.dart';
import 'package:vale_vantagens/commons/widgets/default_app_bar.dart';
import 'package:vale_vantagens/core/utils/text_styles.dart';
import 'package:vale_vantagens/modules/register_discount/register_discount_module.dart';

import '../../../../core/utils/app_colors.dart';

class DiscountDetailPage extends StatelessWidget {
  final DiscountEntity discount;
  const DiscountDetailPage({
    super.key,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Detalhe do desconto',
        onTapBackButton: () => Modular.to.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 15.0,
              ),
              Container(
                height: 400.0,
                width: 400.0,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.silver),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: FittedBox(
                  fit: BoxFit.none,
                  child: Image.network(
                    discount.image,
                    height: 350,
                    width: 350,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2.5),
                ),
                child: Text(
                  saved(),
                  style: TextStyles.smallRegular.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    child: Text(
                      formatCurrency(calcDiscount()),
                      style: TextStyles.smallMedium.copyWith(
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Visibility(
                    visible: discount.discountType != DiscountType.takePay,
                    child: Text(
                      formatCurrency(discount.price),
                      style: TextStyles.smallRegular
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                discount.name,
                style: TextStyles.titleMedium,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                discount.description,
                style: TextStyles.smallRegular,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DefaultButton(
                    onPressed: () {
                      Modular.to.pushNamed(
                        RegisterDiscountModule.initial.completePath,
                        arguments: discount,
                      );
                    },
                    buttonText: 'Editar desconto',
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String saved() {
    return switch (discount.discountType) {
      DiscountType.price => 'Economize ${formatCurrency(calcDiscount())}',
      DiscountType.percentage => '${calcDiscount().toInt()}% Desconto',
      DiscountType.takePay =>
        'Leve ${discount.takeAmount} Pague ${discount.payAmount}',
    };
  }

  double calcDiscount() {
    double result = discount.price;
    if (discount.discountType == DiscountType.price) {
      result = discount.price - discount.priceTo!;
    }

    if (discount.discountType == DiscountType.percentage) {
      result = discount.discountPercentage! / 100 * discount.price;
    }

    return result;
  }

  String formatCurrency(double value) {
    return NumberFormat.simpleCurrency(locale: "en_US").format(value);
  }
}
