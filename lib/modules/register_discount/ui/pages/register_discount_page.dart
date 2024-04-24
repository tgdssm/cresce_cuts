import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:vale_vantagens/commons/commons.dart';
import 'package:vale_vantagens/commons/entities/entities.dart';
import 'package:vale_vantagens/commons/widgets/default_app_bar.dart';
import 'package:vale_vantagens/commons/widgets/default_error.dart';
import 'package:vale_vantagens/core/state_management/consumer_widget.dart';
import 'package:vale_vantagens/core/state_management/state_management.dart';
import 'package:vale_vantagens/core/state_management/states/error_state.dart';
import 'package:vale_vantagens/core/state_management/states/loading_state.dart';
import 'package:vale_vantagens/modules/products/products_module.dart';
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
  late String image;
  final name = TextEditingController();
  final description = TextEditingController();
  DiscountType type = DiscountType.price;
  final price = TextEditingController();
  final priceTo = TextEditingController();
  final discountPercentage = TextEditingController();
  final takeAmount = TextEditingController();
  final payAmount = TextEditingController();
  final activationDateController = TextEditingController();
  final inactivationDateController = TextEditingController();
  DateTime activationDate = DateTime.now();
  DateTime? inactivationDate;

  @override
  void initState() {
    if (widget.discount != null) {
      setFieldWithDiscount();
    } else {
      setFieldWithProduct();
    }

    bloc.updateDiscountType(type);

    super.initState();
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
          if (state is ErrorState) {
            return DefaultError(errorText: state.message);
          }
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
                        key: const Key('name'),
                        title: 'Nome do desconto',
                        controller: name,
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: DefaultTextField(
                        key: const Key('description'),
                        title: 'Descrição',
                        controller: description,
                        maxLines: 3,
                        validator: defaultValidator,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: DefaultDropdown<String>(
                        key: const Key('type'),
                        value: type.name,
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
                                key: const Key('priceOf'),
                                title: 'Preço “DE”',
                                controller: price,
                                digitsOnly: true,
                                isCurrency: true,
                                validator: (value) {
                                  defaultValidator(value);
                                  if (value == '\$0.00') {
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
                                key: const Key('priceTo'),
                                title: 'Preço “POR”',
                                controller: priceTo,
                                digitsOnly: true,
                                isCurrency: true,
                                validator: (value) {
                                  defaultValidator(value);
                                  if (value == '\$0.00') {
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
                                key: const Key('price'),
                                title: 'Preço',
                                controller: price,
                                digitsOnly: true,
                                isCurrency: true,
                                validator: (value) {
                                  defaultValidator(value);
                                  if (value == '\$0.00') {
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
                                key: const Key('percentage'),
                                title: 'Percentual',
                                controller: discountPercentage,
                                digitsOnly: true,
                                validator: defaultValidator,
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
                                    key: const Key('take'),
                                    title: 'Leve',
                                    controller: takeAmount,
                                    digitsOnly: true,
                                    validator: (value) {
                                      defaultValidator(value);
                                      if (value == '0') {
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
                                    key: const Key('pay'),
                                    title: 'Pague',
                                    controller: payAmount,
                                    digitsOnly: true,
                                    validator: (value) {
                                      defaultValidator(value);
                                      if (value == '0') {
                                        return 'Informe um valor';
                                      }
                                      if ((int.tryParse(value!) ?? 0) >
                                          (int.tryParse(takeAmount.text) ??
                                              0)) {
                                        return 'A quantidade deve ser menor que a quantidade paga';
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
                              key: const Key('product-price'),
                              title: 'Preço',
                              controller: price,
                              digitsOnly: true,
                              isCurrency: true,
                              validator: (value) {
                                defaultValidator(value);
                                if (value == '\$0.00') {
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
                              controller: activationDateController,
                              isDatePicker: true,
                              onChangedDate: (date) {
                                activationDate = date;
                              },
                              validator: defaultValidator,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: DefaultTextField(
                              title: 'Data inativação',
                              controller: inactivationDateController,
                              isDatePicker: true,
                              onChangedDate: (date) {
                                inactivationDate = date;
                              },
                              validator: defaultValidator,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                      key: const Key('button'),
                      loading: state is LoadingState,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await bloc.register(
                            DiscountEntity(
                              id: id,
                              name: name.text,
                              description: description.text,
                              image: image,
                              discountType: type,
                              price: removeMoneyMask(price.text),
                              priceTo: removeMoneyMask(priceTo.text),
                              payAmount: int.tryParse(payAmount.text),
                              takeAmount: int.tryParse(takeAmount.text),
                              discountPercentage:
                                  double.tryParse(discountPercentage.text),
                              activationDate: activationDate,
                              inactivationDate: inactivationDate,
                            ),
                            () => Modular.to.popUntil(
                              ModalRoute.withName(
                                ProductsModule.root.completePath,
                              ),
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
    return double.tryParse(money.replaceAll('\$', '')) ?? 0;
  }

  String? defaultValidator(String? value) {
    if (value!.isEmpty) {
      return 'Preencha o campo';
    }
    return null;
  }

  void setFieldWithDiscount() {
    id = widget.discount!.id;
    image = widget.discount!.image;
    name.text = widget.discount!.name;
    description.text = widget.discount!.description;
    type = widget.discount!.discountType;
    price.text = formatterCurrency(widget.discount!.price);
    priceTo.text = formatterCurrency(widget.discount!.priceTo ?? 0);
    discountPercentage.text =
        widget.discount!.discountPercentage?.toString() ?? '0';
    takeAmount.text = widget.discount!.takeAmount?.toString() ?? '0';
    payAmount.text = widget.discount!.payAmount?.toString() ?? '0';
    activationDate = widget.discount!.activationDate;
    inactivationDate = widget.discount!.inactivationDate;
    activationDateController.text =
        DateFormat('dd/MM/yyyy').format(widget.discount!.activationDate);
    inactivationDateController.text =
        DateFormat('dd/MM/yyyy').format(widget.discount!.inactivationDate!);
  }

  void setFieldWithProduct() {
    id = const Uuid().v4();
    image = widget.product!.image;
    name.text = widget.product!.title;
    description.text = widget.product!.description;
    price.text = formatterCurrency(widget.product!.price);
    priceTo.text = formatterCurrency(0);
  }

  String formatterCurrency(double value) {
    final formatter = NumberFormat.simpleCurrency(locale: "en_US");
    return formatter.format(value);
  }
}
