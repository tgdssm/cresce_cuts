import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_styles.dart';

class DefaultDropdown<T> extends StatefulWidget {
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String title;
  const DefaultDropdown({
    super.key,
    required this.onChanged,
    required this.items,
    required this.title,
  });

  @override
  State<DefaultDropdown<T>> createState() => _DefaultDropdownState<T>();
}

class _DefaultDropdownState<T> extends State<DefaultDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyles.smallRegular,
        ),
        const SizedBox(
          height: 8.0,
        ),
        DropdownButtonFormField<T>(
          focusColor: AppColors.white,
          decoration: InputDecoration(
            border: border,
            focusedBorder: border,
          ),
          validator: (value) {
            if (value == null) {
              return 'Escolha um dos items';
            }
            return null;
          },
          items: widget.items
              .map<DropdownMenuItem<T>>(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString()),
                ),
              )
              .toList(),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  OutlineInputBorder get border => OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.silver,
        ),
        borderRadius: BorderRadius.circular(10.0),
      );
}
