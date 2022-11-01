import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/cart/repository/cart_repository.dart';
import 'package:quitanda/src/pages/cart/result/cart_result.dart';
import 'package:quitanda/src/services/utils_services.dart';

import '../../../widgets/payment_widget.dart';

class CartController extends GetxController {
  final repository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  bool isLoadingCheckout = false;

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

  int getItemIndex(ItemModel item) {
    return items.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await repository.changeItemQuantity(
      cartItemId: item.id,
      token: authController.user.token!,
      quantity: quantity,
    );

    if (result) {
      print('chamou');
      if (quantity == 0) {
        items.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        items.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
      update();
    } else {
      utilsServices.showToast(
        message: 'Ocorreu um erro ao salvar produto',
        isError: true,
      );
    }

    return result;
  }

  Future<void> addItemtoCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      // Já existe
      final product = items[itemIndex];

      await changeItemQuantity(
        item: product,
        quantity: product.quantity + quantity,
      );
    } else {
      final CartResult<String> result = await repository.addItemToCart(
          userId: authController.user.id!,
          token: authController.user.token!,
          productId: item.id,
          quantity: quantity);

      result.when(
        success: (cartItemId) {
          // Não existe
          items.add(
            CartItemModel(
              item: item,
              quantity: quantity,
              id: cartItemId,
            ),
          );
        },
        error: (error) => utilsServices.showToast(
          message: error,
          isError: true,
        ),
      );
    }

    update();
  }

  void setLoadingCheckout(bool value) {
    isLoadingCheckout = value;
    update();
  }

  Future checkout() async {
    setLoadingCheckout(true);

    final result = await repository.checkout(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );

    setLoadingCheckout(false);

    result.when(
      success: (order) {
        items.clear();
        update();

        showDialog(
          context: Get.context!,
          builder: (context) {
            return PaymentDialog(order: order);
          },
        );
      },
      error: (error) {
        utilsServices.showToast(message: error);
      },
    );
  }
}
