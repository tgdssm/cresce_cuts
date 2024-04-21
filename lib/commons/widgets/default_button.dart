import 'package:flutter/material.dart';
import 'package:vale_vantagens/core/utils/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool loading;
  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Visibility(
        visible: loading,
        replacement: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14.0,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: const SizedBox(
          height: 20.0,
          width: 20.0,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        ),
      ),
    );
  }
}
