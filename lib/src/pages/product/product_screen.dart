import 'package:flutter/material.dart';
import 'package:quitanda/src/config/custom_color.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/services/utils_services.dart';
import 'package:quitanda/src/widgets/quantity_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.item});

  final ItemModel item;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices = UtilsServices();

  int cartQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          // Content Product detail
          Column(
            children: [
              // Image
              Expanded(
                child: Hero(
                  tag: widget.item.img,
                  child: Image.network(widget.item.img),
                ),
              ),

              // Details
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),

                  // Decoration
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.grey.shade400,
                      )
                    ],
                  ),

                  // Content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name - Quantity
                      Row(
                        children: [
                          // Name
                          Expanded(
                            child: Text(
                              widget.item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Quantity
                          QuantityWidget(
                            sufixText: widget.item.unit,
                            value: cartQuantity,
                            result: (quantity) {
                              setState(() {
                                cartQuantity = quantity;
                              });
                            },
                          )
                        ],
                      ),

                      // Price
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),

                      // Description
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.item.description,
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                        ),
                      ),

                      // Button
                      SizedBox(
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {},
                          label: const Text(
                            'Adicionar ao carrinho',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Back arrow button
          Positioned(
            top: 14,
            left: 14,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
