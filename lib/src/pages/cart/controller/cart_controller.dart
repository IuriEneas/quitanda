import 'package:get/get.dart';
import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/cart/repository/cart_repository.dart';
import 'package:quitanda/src/pages/cart/result/cart_result.dart';
import 'package:quitanda/src/services/utils_services.dart';

class CartController extends GetxController {
  final repository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> items = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in items) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await repository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        items = data;
        update();
      },
      error: (error) {
        utilsServices.showToast(
          message: 'Algo deu errado $error',
          isError: true,
        );
      },
    );
  }
}