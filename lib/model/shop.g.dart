// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
      productList: (json['productList'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'productList': instance.productList,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      coinNum: (json['coinNum'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      periodType: (json['periodType'] as num).toInt(),
      periodVal: (json['periodVal'] as num).toInt(),
      currency: json['currency'] as String,
      createTime: json['createTime'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'coinNum': instance.coinNum,
      'type': instance.type,
      'periodType': instance.periodType,
      'periodVal': instance.periodVal,
      'currency': instance.currency,
      'createTime': instance.createTime,
    };
