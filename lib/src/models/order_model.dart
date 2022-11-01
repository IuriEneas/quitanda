import 'package:json_annotation/json_annotation.dart';
import 'package:quitanda/src/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;
  DateTime? createDate;

  @JsonKey(name: 'due')
  DateTime overdueDate;
  String status;

  String qrCodeImage;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;
  double total;

  OrderModel({
    required this.id,
    required this.items,
    required this.createDate,
    required this.overdueDate,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    required this.qrCodeImage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
