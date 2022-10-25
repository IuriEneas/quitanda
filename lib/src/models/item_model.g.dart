// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as String? ?? '',
      description: json['description'] as String,
      img: json['picture'] as String,
      name: json['title'] as String,
      unit: json['unit'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.name,
      'picture': instance.img,
      'unit': instance.unit,
      'price': instance.price,
      'description': instance.description,
    };
