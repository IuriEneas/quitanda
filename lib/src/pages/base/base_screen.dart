import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/pages/base/controller/navigation_controller.dart';
import 'package:quitanda/src/pages/cart/view/cart_tab.dart';
import 'package:quitanda/src/pages/orders/view/orders_tab.dart';
import 'package:quitanda/src/pages/profile/profile_tab.dart';

import '../home/view/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: navigationController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),

      // Bottom navigation
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          onTap: (index) {
            navigationController.navigatePageView(index);
            navigationController.pageController.animateToPage(
              index,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 600),
            );
          },

          // Items
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Carrinho',
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Pedidos',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
                label: 'Perfil', icon: Icon(Icons.person_outline))
          ],
        ),
      ),
    );
  }
}
