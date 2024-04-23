import 'package:vale_vantagens/commons/entities/discount_entity.dart';

enum DiscountType {
  price('Preço "DE" - Preço "POR"'),
  percentage('Porcetagem de desconto'),
  takePay('Leve - Pague');

  const DiscountType(this.name);
  final String name;

  static DiscountType fromName(String name) {
    return DiscountType.values.firstWhere(
      (element) => element.name == name,
      orElse: () => DiscountType.price,
    );
  }
}

class DiscountModel {
  final String id;
  final String name;
  final String description;
  final DiscountType discountType;
  final double price;
  final double? priceTo;
  final double? discountPercentage;
  final int? takeAmount;
  final int? payAmount;
  final DateTime activationDate;
  final DateTime? inactivationDate;

  DiscountModel({
    required this.id,
    required this.name,
    required this.description,
    required this.discountType,
    required this.price,
    this.priceTo,
    this.discountPercentage,
    this.takeAmount,
    this.payAmount,
    required this.activationDate,
    this.inactivationDate,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      discountType: DiscountType.values[json['discountType']],
      price: json['price'].toDouble(),
      priceTo: json['priceTo']?.toDouble(),
      discountPercentage: json['discountPercentage']?.toDouble(),
      takeAmount: json['takeAmount'],
      payAmount: json['payAmount'],
      activationDate: DateTime.parse(json['activationDate']),
      inactivationDate: json['inactivationDate'] != null
          ? DateTime.parse(json['inactivationDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'discountType': discountType.index,
      'price': price,
      'priceTo': priceTo,
      'discountPercentage': discountPercentage,
      'takeAmount': takeAmount,
      'payAmount': payAmount,
      'activationDate': activationDate.toIso8601String(),
      'inactivationDate': inactivationDate?.toIso8601String(),
    };
  }

  DiscountEntity toEntity() => DiscountEntity(
        id: id,
        name: name,
        description: description,
        discountType: discountType,
        price: price,
        priceTo: priceTo,
        discountPercentage: discountPercentage,
        takeAmount: takeAmount,
        payAmount: payAmount,
        activationDate: activationDate,
        inactivationDate: inactivationDate,
      );
}
