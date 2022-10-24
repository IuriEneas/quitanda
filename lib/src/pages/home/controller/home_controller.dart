import 'package:get/get.dart';
import 'package:quitanda/src/models/category_model.dart';
import 'package:quitanda/src/pages/home/repository/home_repository.dart';
import 'package:quitanda/src/pages/home/result/home_result.dart';
import 'package:quitanda/src/services/utils_services.dart';

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  bool isLoading = false;
  List<CategoryModel> categories = [];
  CategoryModel? currentCategory;
  UtilsServices utilsServices = UtilsServices();

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
  }

  void setLoading(bool bool) {
    isLoading = bool;
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
}
