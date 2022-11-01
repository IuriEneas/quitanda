// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createDate: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      overdueDate: DateTime.parse(json['due'] as String),
      status: json['status'] as String,
      copyAndPaste: json['copiaecola'] as String,
      total: (json['total'] as num).toDouble(),
      qrCodeImage: json['qrCodeImage'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createDate?.toIso8601String(),
      'due': instance.overdueDate.toIso8601String(),
      'items': instance.items,
      'status': instance.status,
      'qrCodeImage': instance.qrCodeImage,
      'copiaecola': instance.copyAndPaste,
      'total': instance.total,
    };
