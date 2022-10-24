import 'package:quitanda/src/models/cart_item_model.dart';

class OrderModel {
  String id;
  List<CartItemModel> items;
  DateTime createDate;
  DateTime overdueDate;
  String status;
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
  });
}
