import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quitanda/src/pages/cart/controller/cart_controller.dart';
import 'package:quitanda/src/services/utils_services.dart';
import 'package:quitanda/src/config/custom_color.dart';
import 'package:quitanda/src/config/app_data.dart' as app_data;
import 'package:quitanda/src/widgets/payment_widget.dart';

import 'components/cart_tile.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  double cartTotalPrice() {
    double total = 0;

    for (var item in app_data.cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      // Body
      body: Column(
        children: [
          // ListView Cart items
          GetBuilder<CartController>(
            builder: (controller) {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return CartTile(
                      itemCart: controller.items[index],
                      updatedQuantity: (quantity) {},
                    );
                  },
                ),
              );
            },
          ),

          // Bottom sheet total
          Container(
            padding: const EdgeInsets.all(16),

            // Decoration
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 10,
                  spreadRadius: 5,
                )
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),

            // Content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Total geral Text
                const Text(
                  'Total geral: ',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),

                // Price text
                GetBuilder<CartController>(
                  builder: (_) {
                    return Text(
                      utilsServices.priceToCurrency(_.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 23,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                // Spacer
                const SizedBox(height: 20),

                // Concluir pedido button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PaymentDialog(order: app_data.orders.first);
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Concluir Pedido',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Confirmation Function
  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja confirmar o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
