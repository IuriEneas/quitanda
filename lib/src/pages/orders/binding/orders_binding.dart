import 'package:get/get.dart';
import 'package:quitanda/src/pages/orders/controller/order_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrdersController());
  }
}
