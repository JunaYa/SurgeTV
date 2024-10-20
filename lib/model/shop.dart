
import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable()
class ProductList {
  final List<Product> productList;

  ProductList({required this.productList});

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);
  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}

@JsonSerializable()
class Product {
  final int id;
  final String name;
  final double price;
  final int coinNum;
  final int type;
  final int periodType;
  final int periodVal;
  final String currency;
  final String createTime;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.coinNum,
    required this.type,
    required this.periodType,
    required this.periodVal,
    required this.currency,
    required this.createTime,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
