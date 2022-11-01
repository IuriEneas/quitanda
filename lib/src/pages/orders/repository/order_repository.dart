import 'package:quitanda/src/constants/endpoints.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/services/http_maneger.dart';

import '../../../models/cart_item_model.dart';
import '../result/order_result.dart';

class OrderRepository {
  final _httpManager = HttpManager();

  Future<OrderResult<List<OrderModel>>> getOrders(
      {required String userId, required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrderResult<List<OrderModel>>.success(orders);
    } else {
      return OrderResult.error('Não foi possível carregar dados');
    }
  }

  Future<OrderResult<List<CartItemModel>>> getOrderItems(
      {required String orderId, required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      body: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrderResult<List<CartItemModel>>.success(items);
    } else {
      return OrderResult.error('Não foi possivel recuperar itens');
    }
  }
}
