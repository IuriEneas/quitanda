import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/services/utils_services.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({super.key, required this.order});

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Pagamento com Pix',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // QR code
                QrImage(
                  data:
                      'https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley',
                  version: QrVersions.auto,
                  size: 200,
                ),

                // Expiration
                Text(
                  'Vencimento: ${utilsServices.formatDatetime(order.overdueDate)}',
                  style: const TextStyle(fontSize: 12),
                ),

                // Total
                Text(
                  'Vencimento: ${utilsServices.priceToCurrency(order.total)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Button copy to clipboard
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      )),
                  label: const Text('Copiar código pix'),
                  icon: const Icon(Icons.copy),
                )
              ],
            ),
          ),

          // CLose button
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
              splashRadius: 20,
            ),
          ),
        ],
      ),
    );
  }
}
