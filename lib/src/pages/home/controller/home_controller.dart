import 'package:get/get.dart';
import 'package:quitanda/src/models/category_model.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/pages/home/repository/home_repository.dart';
import 'package:quitanda/src/pages/home/result/home_result.dart';
import 'package:quitanda/src/services/utils_services.dart';

const int itensPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> categories = [];
  CategoryModel? currentCategory;
  UtilsServices utilsServices = UtilsServices();

  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    getAllProducts();
  }

  void setLoading(bool bool, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = bool;
    } else {
      isProductLoading = bool;
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    homeResult.when(
      success: (data) {
        categories.assignAll(data);
        if (categories.isEmpty) return;
        selectCategory(categories.first);
      },
      error: (message) {
        utilsServices.showToast(
          message: 'Ocorreu um erro: $message',
          isError: true,
        );
      },
    );

    setLoading(false);
  }

  Future<void> getAllProducts() async {
    setLoading(true, isProduct: true);

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itensPerPage,
    };

    HomeResult<ItemModel> itemResult =
        await homeRepository.getAllProducts(body);

    setLoading(false, isProduct: true);

    itemResult.when(
      success: (data) {
        currentCategory!.items = data;
        print(data);
      },
      error: (message) {
        utilsServices.showToast(message: message);
      },
    );
  }
}
