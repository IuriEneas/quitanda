import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/config/custom_color.dart';
import 'package:quitanda/src/pages/base/controller/navigation_controller.dart';
import 'package:quitanda/src/pages/cart/controller/cart_controller.dart';
import 'package:quitanda/src/pages/home/controller/home_controller.dart';
import 'package:quitanda/src/widgets/custom_shimmer.dart';
import 'components/category_tile.dart';
import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          // App name
          TextSpan(
            style: const TextStyle(fontSize: 30),
            children: [
              TextSpan(
                text: 'Green',
                style: TextStyle(color: CustomColors.customSwatchColor),
              ),
              TextSpan(
                text: 'grocer',
                style: TextStyle(color: CustomColors.customContrastColor),
              ),
            ],
          ),
        ),
        actions: [
          // Cart Button
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GetBuilder<CartController>(
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    final navigationController =
                        Get.find<NavigationController>();

                    navigationController.navigatePageView(NavigationTabs.cart);
                  },
                  child: Badge(
                    badgeColor: CustomColors.customContrastColor,
                    badgeContent: Text(
                      _.items.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: CustomColors.customSwatchColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Field
          GetBuilder<HomeController>(
            builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: _searchController,
                  onFieldSubmitted: (text) {
                    controller.searchTitle.value = text;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    hintText: 'Pesquise aqui...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    suffixIcon: controller.searchTitle.value.isNotEmpty
                        ? IconButton(
                            splashRadius: 2,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 21,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              controller.searchTitle.value = '';
                              FocusScope.of(context).unfocus();
                            },
                          )
                        : null,
                    prefixIcon: Icon(
                      Icons.search,
                      color: CustomColors.customContrastColor,
                      size: 21,
                    ),
                  ),
                ),
              );
            },
          ),

          // Categories
          GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return !controller.isCategoryLoading
                        ? CategoryTile(
                            category: controller.categories[index].title,
                            isSelected: controller.categories[index] ==
                                controller.currentCategory,
                            onPressed: () {
                              controller.selectCategory(
                                controller.categories[index],
                              );
                            },
                          )
                        : Container(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: CustomShimmer(
                              height: double.infinity,
                              width: 60,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: !controller.isCategoryLoading
                      ? controller.categories.length
                      : 5,
                ),
              );
            },
          ),

          // Products Gridview Structure
          GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Expanded(
                child: !controller.isProductLoading
                    ? Visibility(
                        visible: (controller.currentCategory?.items ?? [])
                            .isNotEmpty,
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              color: CustomColors.customSwatchColor,
                              size: 50,
                            ),
                            const Text('N??o h?? itens para apresentar'),
                          ],
                        ),

                        // Grid Products
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 9 / 11.5,
                          ),
                          itemCount: controller.allProducts.length,
                          itemBuilder: (context, index) {
                            if (((index + 1) ==
                                    controller.allProducts.length) &&
                                !controller.isLastPage) {
                              controller.loadMoreProducts();
                            }

                            return ItemTile(
                                item: controller.allProducts[index]);
                          },
                        ),
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                        children: List.generate(
                          6,
                          (index) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
