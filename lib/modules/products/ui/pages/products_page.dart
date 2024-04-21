import 'package:flutter/material.dart';
import 'package:vale_vantagens/commons/commons.dart';
import 'package:vale_vantagens/core/state_management/consumer_widget.dart';
import 'package:vale_vantagens/core/state_management/state_management.dart';
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
      body: ConsumerWidget(
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefaultSwitch(onChanged: (value) {
                  print(value);
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
