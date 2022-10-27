import 'package:quitanda/src/constants/endpoints.dart';
import 'package:quitanda/src/services/http_maneger.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      print(result);
    } else {
      print('erro');
    }
  }
}
