import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/text_styles.dart';

class TileDateDiscountWidget extends StatelessWidget {
  final String title;
  final DateTime date;
  const TileDateDiscountWidget({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.smallMedium,
        ),
        Text(
          DateFormat('dd/MM/yyyy').format(date),
          style: TextStyles.smallRegular,
        )
      ],
    );
  }
}
