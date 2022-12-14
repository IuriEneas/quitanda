import 'package:quitanda/src/constants/endpoints.dart';
import 'package:quitanda/src/models/category_model.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/pages/home/result/home_result.dart';
import 'package:quitanda/src/services/http_maneger.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error('Ocorreu um erro ao recuperar categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
    Map<String, dynamic> body,
  ) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getProducts,
      method: HttpMethods.post,
      body: body,
    );

    if (result['result'] == null) return HomeResult.error('message');

    List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
        .map((e) => ItemModel.fromJson(e))
        .toList();

    return HomeResult.success(data);
  }
}
