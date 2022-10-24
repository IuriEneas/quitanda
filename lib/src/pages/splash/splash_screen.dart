import 'package:flutter/material.dart';
import 'package:quitanda/src/config/custom_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        color: CustomColors.customSwatchColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 40),
                children: [
                  const TextSpan(
                    text: 'Green',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'grocer',
                    style: TextStyle(color: CustomColors.customContrastColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          ],
        ),
      ),
    );
  }
}
