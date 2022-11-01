import 'package:get/get.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/orders/repository/order_repository.dart';
import 'package:quitanda/src/services/utils_services.dart';

import '../../../models/order_model.dart';
import '../result/order_result.dart';

class OrdersController extends GetxController {
  final repository = OrderRepository();
  List<OrderModel> orders = [];
  final authController = Get.find<AuthController>();
  UtilsServices utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();

    getOrders();
  }

  Future<void> getOrders() async {
    orders.clear();
    update();

    OrderResult<List<OrderModel>> result = await repository.getOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (bodyOrders) {
        orders = bodyOrders;
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
