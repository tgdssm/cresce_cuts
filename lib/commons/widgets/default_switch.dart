import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vale_vantagens/core/utils/app_colors.dart';

class DefaultSwitch extends StatefulWidget {
  final void Function(bool) onChanged;
  const DefaultSwitch({super.key, required this.onChanged});

  @override
  State<DefaultSwitch> createState() => _DefaultSwitchState();
}

class _DefaultSwitchState extends State<DefaultSwitch> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
        });
        widget.onChanged(value);
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedContainer(
            height: 20.0,
            width: 50.0,
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              color: value ? AppColors.primaryColor.withOpacity(.5) : AppColors.silver,
              borderRadius: BorderRadius.circular(10.0)
            ),
          ),
          SizedBox(
            width:  50.0,
            child: AnimatedAlign(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              child: Container(
                height: 28.0,
                width: 28.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
