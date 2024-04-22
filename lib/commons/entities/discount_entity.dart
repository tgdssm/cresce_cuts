import '../models/discount_model.dart';

class DiscountEntity {
  final int id;
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

  DiscountEntity({
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
}
