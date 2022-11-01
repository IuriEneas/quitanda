import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/pages/cart/controller/cart_controller.dart';
import 'package:quitanda/src/services/utils_services.dart';
import 'package:quitanda/src/widgets/quantity_widget.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.itemCart});

  final CartItemModel itemCart;
  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        // image
        leading: Image.network(
          widget.itemCart.item.img,
          height: 60,
          width: 60,
        ),

        // Title
        title: Text(
          widget.itemCart.item.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // Total
        subtitle: Text(
          utilsServices.priceToCurrency(widget.itemCart.totalPrice()),
        ),

        // Quantidade
        trailing: QuantityWidget(
          value: widget.itemCart.quantity,
          sufixText: widget.itemCart.item.unit,
          result: (quantity) {
            controller.changeItemQuantity(
              item: widget.itemCart,
              quantity: quantity,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
