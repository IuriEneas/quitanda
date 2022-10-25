import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quitanda/src/config/custom_color.dart';
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
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
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
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors.customContrastColor,
                  size: 21,
                ),
              ),
            ),
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

          // Products Gridview
          GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Expanded(
                child: !controller.isProductLoading
                    ? GridView.builder(
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
                          return ItemTile(item: controller.allProducts[index]);
                        },
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
