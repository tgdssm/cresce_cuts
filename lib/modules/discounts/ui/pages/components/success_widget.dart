import 'package:flutter/material.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/discounts/ui/pages/components/discount_card_widget.dart';

class SuccessWidget extends StatelessWidget {
  final List<DiscountEntity> discounts;
  const SuccessWidget({
    super.key,
    required this.discounts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 25.0,
      ),
      itemCount: discounts.length,
      itemBuilder: (context, index) {
        return DiscountCardWidget(
          discount: discounts[index],
        );
      },
    );
  }
}
