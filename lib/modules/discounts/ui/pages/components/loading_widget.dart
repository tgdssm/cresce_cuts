import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vale_vantagens/commons/widgets/shimmer.dart';
import 'package:vale_vantagens/core/utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(
          height: 50.0,
        ),
        itemBuilder: (context, index) => Container(
          height: 220.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: AppColors.silver,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          height: 30.0,
                          width: 270.0,
                          decoration: BoxDecoration(
                            color: AppColors.silver,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        height: 30.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: AppColors.silver,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        height: 30.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: AppColors.silver,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
