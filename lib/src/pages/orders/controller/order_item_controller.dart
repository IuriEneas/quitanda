import 'package:get/get.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/orders/repository/order_repository.dart';
import 'package:quitanda/src/services/utils_services.dart';

import '../../../models/cart_item_model.dart';
import '../result/order_result.dart';

class OrderItemController extends GetxController {
  final repository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  OrderModel order;

  bool isLoading = false;

  setIsLoading(bool value) {
    isLoading = value;
    update();
  }

  OrderItemController(this.order);

  Future<void> getOrderItems() async {
    setIsLoading(true);

    final OrderResult<List<CartItemModel>> result =
        await repository.getOrderItems(
      orderId: order.id,
      token: authController.user.token!,
    );

    setIsLoading(false);

    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (error) {
        utilsServices.showToast(
          message: error,
          isError: true,
        );
      },
    );
  }
}
