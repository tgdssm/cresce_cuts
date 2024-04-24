import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/commons/commons.dart';
import 'package:vale_vantagens/commons/widgets/default_app_bar.dart';
import 'package:vale_vantagens/commons/widgets/default_error.dart';
import 'package:vale_vantagens/core/state_management/consumer_widget.dart';
import 'package:vale_vantagens/core/state_management/state_management.dart';
import 'package:vale_vantagens/core/state_management/states/base_state.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/core/state_management/states/success_state.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/modules/discounts/discounts_module.dart';
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
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Produtos',
        onTapBackButton: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ConsumerWidget<BaseState>(
                bloc: bloc,
                builder: (context, state) {
                  return switch (state) {
                    LoadingState() => const LoadingWidget(
                        key: Key('LoadingWidget'),
                      ),
                    ErrorState() => DefaultError(
                        key: const Key('DefaultError'),
                        errorText: state.message,
                      ),
                    SuccessState<List<ProductEntity>>() => SuccessWidget(
                        key: const Key('SuccessWidget'),
                        products: state.data,
                      ),
                    _ => Container(),
                  };
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            DefaultButton(
              onPressed: () {
                Modular.to.pushNamed(DiscountsModule.initial.completePath);
              },
              buttonText: 'Ver descontos',
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
