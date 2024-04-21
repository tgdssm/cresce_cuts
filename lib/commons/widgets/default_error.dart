import 'package:flutter/material.dart';
import 'package:vale_vantagens/core/utils/app_colors.dart';

class DefaultError extends StatelessWidget {
  final String? errorText;
  const DefaultError({
    super.key,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.warning,
          color: AppColors.red,
          size: 80.0,
        ),
        Text(
          errorText ?? 'Ops! Algo deu errado.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 80.0,)
      ],
    );
  }
}
