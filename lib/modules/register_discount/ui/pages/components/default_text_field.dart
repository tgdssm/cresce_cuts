import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vale_vantagens/core/utils/app_colors.dart';
import 'package:vale_vantagens/core/utils/text_styles.dart';

class DefaultTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool isDatePicker;
  final int maxLines;
  final bool digitsOnly;
  final String? Function(String?)? validator;
  final ValueChanged<DateTime>? onChangedDate;
  final bool isCurrency;

  const DefaultTextField({
    super.key,
    required this.title,
    this.controller,
    this.isDatePicker = false,
    this.maxLines = 1,
    this.digitsOnly = false,
    this.validator,
    this.isCurrency = false,
    this.onChangedDate,
  });

  List<TextInputFormatter> inputFormatters() {
    final inputFormatters = <TextInputFormatter>[];

    if (digitsOnly) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }
    if (isCurrency) {
      inputFormatters.add(MoneyTextInputFormatter());
    }
    return inputFormatters;
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = controller ?? TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.smallRegular,
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextFormField(
          controller: ctrl,
          readOnly: isDatePicker,
          maxLines: maxLines,
          keyboardType: digitsOnly ? TextInputType.number : TextInputType.text,
          inputFormatters: inputFormatters(),
          validator: validator,
          decoration: InputDecoration(
            border: border,
            focusedBorder: border,
          ),
          onTap: isDatePicker
              ? () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                    ctrl.text = formattedDate;
                    onChangedDate?.call(pickedDate);
                  }
                }
              : null,
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

class MoneyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "en_US");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
