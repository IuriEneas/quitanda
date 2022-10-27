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

  RxString searchTitle = ''.obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itensPerPage) return true;

    return currentCategory!.pagination * itensPerPage > allProducts.length;
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();

    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    if (currentCategory!.items.isNotEmpty) return;

    getAllProducts();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;

    getAllProducts(canLoad: false);
  }

  void setLoading(bool bool, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = bool;
    } else {
      isProductLoading = bool;
    }

    update();
  }

  void filterByTitle() {
    // Apagar todos os itens das categorias
    for (var category in categories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      categories.removeAt(0);
    } else {
      CategoryModel? c = categories.firstWhereOrNull((cat) => cat.id == '');

      if (c == null) {
        // Criar uma nova categoria em todos
        final todosCategory = CategoryModel(
          id: '',
          title: 'Todos',
          items: [],
          pagination: 0,
        );

        categories.insert(0, todosCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = categories.first;

    update();
    getAllProducts();
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

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itensPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> itemResult =
        await homeRepository.getAllProducts(body);

    setLoading(false, isProduct: true);

    itemResult.when(
      success: (data) {
        currentCategory!.items.addAll(data);
      },
      error: (message) {
        utilsServices.showToast(message: message);
      },
    );
  }
}
