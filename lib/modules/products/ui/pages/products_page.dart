import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vale_vantagens/commons/commons.dart';
import 'package:vale_vantagens/commons/widgets/default_app_bar.dart';
import 'package:vale_vantagens/commons/widgets/default_error.dart';
import 'package:vale_vantagens/commons/widgets/shimmer.dart';
import 'package:vale_vantagens/core/state_management/consumer_widget.dart';
import 'package:vale_vantagens/core/state_management/state_management.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/core/utils/app_colors.dart';
import 'package:vale_vantagens/modules/products/domain/entities/entities.dart';
import 'package:vale_vantagens/modules/products/ui/pages/components/loading_widget.dart';
import 'package:vale_vantagens/modules/products/ui/pages/components/success_widget.dart';
import 'package:vale_vantagens/modules/products/ui/pages/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends StateManagement<ProductsPage, ProductsBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Produtos',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ConsumerWidget(
                bloc: bloc,
                builder: (context, state) {
                  return switch (state) {
                    LoadingState() => const LoadingWidget(),
                    ErrorState() => DefaultError(
                        errorText: state.message,
                      ),
                    SuccessState<List<ProductEntity>>() => SuccessWidget(
                        products: state.data,
                      ),
                    _ => Container(),
                  };
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            DefaultButton(onPressed: () {}, buttonText: 'Descontos'),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
