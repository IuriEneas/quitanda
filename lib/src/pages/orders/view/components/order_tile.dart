import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/orders/controller/order_item_controller.dart';
import 'package:quitanda/src/services/utils_services.dart';

import '../../../../widgets/payment_widget.dart';
import 'order_status_widget.dart';

class OrderTile extends StatelessWidget {
  OrderTile({super.key, required this.order});

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderItemController>(
          init: OrderItemController(order),
          global: false,
          builder: (controller) {
            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              // initiallyExpanded: order.status == 'pending_payment',
              onExpansionChanged: (value) {
                if (value && order.items.isEmpty) {
                  controller.getOrderItems();
                }
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Order Id
                  Text('Pedido ${order.id}'),

                  // Order Date
                  Text(
                    utilsServices.formatDatetime(order.createDate!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.all(14),
              children: [
                // Orders List
                IntrinsicHeight(
                  child: Row(
                    children: [
                      // Order List
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 150,
                          child: controller.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView(
                                  children: order.items.map((orderItem) {
                                    return _OrderItemWidget(
                                      utilsServices: utilsServices,
                                      orderItem: orderItem,
                                    );
                                  }).toList(),
                                ),
                        ),
                      ),

                      // Vertical Divider
                      VerticalDivider(
                        color: Colors.grey.shade300,
                        thickness: 2,
                        width: 20,
                      ),

                      // Order Status
                      Expanded(
                        flex: 2,
                        child: OrderStatusWidget(
                          status: order.status,
                          isOverdue: order.overdueDate.isBefore(DateTime.now()),
                        ),
                      )
                    ],
                  ),
                ),

                // Total
                Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 20),
                    children: [
                      const TextSpan(
                        text: 'Total ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: utilsServices.priceToCurrency(order.total)),
                    ],
                  ),
                ),

                // Pix Button
                Visibility(
                  visible: order.status == 'pending_payment' &&
                      order.isOverDue == false,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PaymentDialog(order: order);
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/app_images/pix.png',
                      height: 24,
                    ),
                    label: const Text('Pague com pix'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Order Details Widget
class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.name)),
          Text(utilsServices.priceToCurrency(orderItem.totalPrice())),
        ],
      ),
    );
  }
}
