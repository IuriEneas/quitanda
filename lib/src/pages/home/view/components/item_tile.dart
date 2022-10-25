import 'package:flutter/material.dart';
import 'package:quitanda/src/config/custom_color.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/pages/product/product_screen.dart';
import 'package:quitanda/src/services/utils_services.dart';

class ItemTile extends StatelessWidget {
  ItemTile({super.key, required this.item});

  final ItemModel item;

  UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductScreen(
                  item: item,
                ),
              ),
            );
          },
          child: Card(
            elevation: 3,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            // Item Content
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image
                  Expanded(
                    child: Hero(
                      tag: item.img,
                      child: Image.network(item.img),
                    ),
                  ),

                  // Name
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Price - unit
                  Row(
                    children: [
                      // Price
                      Text(
                        utilsServices.priceToCurrency(item.price),
                        style: TextStyle(
                          fontSize: 20,
                          color: CustomColors.customSwatchColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Unit
                      Text(
                        '/${item.unit}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        // Add to cart button
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            height: 40,
            width: 35,
            decoration: BoxDecoration(
              color: CustomColors.customSwatchColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: const Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
