import 'package:flutter/material.dart';
import 'package:vale_vantagens/core/utils/app_colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onTapBackButton;
  const DefaultAppBar({
    super.key,
    required this.title,
    this.onTapBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  visible: onTapBackButton != null,
                  child: IconButton(
                    onPressed: onTapBackButton,
                    icon: const Icon(
                      size: 32.0,
                      Icons.arrow_back,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: onTapBackButton != null,
                  child: const SizedBox(
                    width: 50.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        onTapBackButton != null ? 75.0 : 60.0,
      );
}
