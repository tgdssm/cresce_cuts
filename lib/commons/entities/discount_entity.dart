import '../models/discount_model.dart';

class DiscountEntity {
  final String id;
  final String name;
  final String description;
  final DiscountType discountType;
  final String image;
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
    required this.image,
    required this.price,
    this.priceTo,
    this.discountPercentage,
    this.takeAmount,
    this.payAmount,
    required this.activationDate,
    this.inactivationDate,
  });

  DiscountModel toModel() => DiscountModel(
        id: id,
        name: name,
        description: description,
        discountType: discountType,
        image: image,
        price: price,
        priceTo: priceTo,
        discountPercentage: discountPercentage,
        takeAmount: takeAmount,
        payAmount: payAmount,
        activationDate: activationDate,
        inactivationDate: inactivationDate,
      );
}
