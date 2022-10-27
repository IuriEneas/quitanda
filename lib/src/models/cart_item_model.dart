import 'package:json_annotation/json_annotation.dart';
import 'package:quitanda/src/models/item_model.dart';

@JsonSerializable()
class CartItemModel {
  ItemModel item;
  int quantity;

  CartItemModel({
    required this.item,
    required this.quantity,
  });

  double totalPrice() => item.price * quantity;
}
