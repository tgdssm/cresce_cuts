import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';
import 'package:vale_vantagens/commons/commons.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/commons/widgets/default_app_bar.dart';
import 'package:vale_vantagens/core/state_management/consumer_widget.dart';
import 'package:vale_vantagens/core/state_management/state_management.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/components/default_dropdown.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/components/default_text_field.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_bloc.dart';
import 'package:vale_vantagens/modules/register_discount/ui/pages/register_discount_states.dart';

import '../../../../commons/models/discount_model.dart';

class RegisterDiscountPage extends StatefulWidget {
  final ProductEntity? product;
  final DiscountEntity? discount;
  const RegisterDiscountPage({
    super.key,
    this.product,
    this.discount,
  });

  @override
  State<RegisterDiscountPage> createState() => _RegisterDiscountPageState();
}

class _RegisterDiscountPageState
    extends StateManagement<RegisterDiscountPage, RegisterDiscountBloc> {
  final formKey = GlobalKey<FormState>();

  late String id;
  final name = TextEditingController();
  final description = TextEditingController();
  DiscountType type = DiscountType.price;
  final price = TextEditingController();
  final priceTo = TextEditingController();
  final discountPercentage = TextEditingController();
  final takeAmount = TextEditingController();
  final payAmount = TextEditingController();
  DateTime activationDate = DateTime.now();
  DateTime? inactivationDate;

  @override
  void initState() {
    if (widget.discount != null) {
      setFieldWithDiscount();
    } else {
      setFieldWithProduct();
    }

    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Cadastro desconto',
        onTapBackButton: () => Modular.to.pop(),
      ),
      body: ConsumerWidget(
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: DefaultTextField(
                        title: 'Nome do desconto',
                        controller: name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: DefaultTextField(
                        title: 'Descrição',
                        controller: description,
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: DefaultDropdown<String>(
                        title: 'Tipo do desconto',
                        onChanged: (value) {
                          type = DiscountType.fromName(value ?? '');
                          bloc.updateDiscountType(type);
                        },
                        items: DiscountType.values.map((e) => e.name).toList(),
                      ),
                    ),
                    if (state is DiscountPriceState)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: DefaultTextField(
                                title: 'Preço “DE”',
                                controller: price,
                                digitsOnly: true,
                                isCurrency: true,
                                validator: (value) {
                                  if (value == 'R\$0,00') {
                                    return 'Informe um valor';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: DefaultTextField(
                                title: 'Preço “POR”',
                                controller: priceTo,
                                digitsOnly: true,
                                isCurrency: true,
                                validator: (value) {
                                  if (value == 'R\$0,00') {
                                    return 'Informe um valor';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is DiscountPercentageState)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: DefaultTextField(
                                title: 'Preço',
                                controller: price,
                                digitsOnly: true,
                                isCurrency: true,
                                validator: (value) {
                                  if (value == 'R\$0,00') {
                                    return 'Informe um valor';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: DefaultTextField(
                                title: 'Percentual de desconto',
                                controller: discountPercentage,
                                digitsOnly: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is DiscountTakePayState)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultTextField(
                                    title: 'Leve',
                                    controller: takeAmount,
                                    digitsOnly: true,
                                    validator: (value) {
                                      if (value == '0') {
                                        return 'Informe um valor';
                                      }
                                      if ((int.tryParse(value!) ?? 0) >
                                          (int.tryParse(priceTo.text) ?? 0)) {
                                        return 'A quantidade deve ser menor que a quantidade paga';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: DefaultTextField(
                                    title: 'Pague',
                                    controller: payAmount,
                                    digitsOnly: true,
                                    validator: (value) {
                                      if (value == '0') {
                                        return 'Informe um valor';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            DefaultTextField(
                              title: 'Preço',
                              controller: price,
                              digitsOnly: true,
                              isCurrency: true,
                              validator: (value) {
                                if (value == 'R\$0,00') {
                                  return 'Informe um valor';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultTextField(
                              title: 'Data ativação',
                              isDatePicker: true,
                              onChangedDate: (date) {
                                activationDate = date;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: DefaultTextField(
                              title: 'Data inativação',
                              isDatePicker: true,
                              onChangedDate: (date) {
                                inactivationDate = date;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                      loading: state is LoadingState,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          bloc.register(
                            DiscountEntity(
                              id: id,
                              name: name.text,
                              description: description.text,
                              discountType: type,
                              price: removeMoneyMask(price.text),
                              priceTo: removeMoneyMask(price.text),
                              payAmount: int.tryParse(payAmount.text),
                              takeAmount: int.tryParse(takeAmount.text),
                              activationDate: activationDate,
                              inactivationDate: inactivationDate,
                            ),
                          );
                        }
                      },
                      buttonText: 'Salvar',
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double removeMoneyMask(String money) {
    return double.tryParse(money.replaceAll('US\$', '')) ?? 0;
  }

  void setFieldWithDiscount() {
    id = widget.discount!.id;
    name.text = widget.discount!.name;
    description.text = widget.discount!.description;
    type = widget.discount!.discountType;
    price.text = widget.discount!.price.toString();
    priceTo.text = widget.discount!.priceTo.toString();
    discountPercentage.text = widget.discount!.discountPercentage.toString();
    takeAmount.text = widget.discount!.takeAmount.toString();
    payAmount.text = widget.discount!.payAmount.toString();
    activationDate = widget.discount!.activationDate;
    inactivationDate = widget.discount!.inactivationDate;
  }

  void setFieldWithProduct() {
    id = const Uuid().v4();
    name.text = widget.product!.title;
    description.text = widget.product!.description;
    price.text = widget.product!.price.toString();
  }
}
