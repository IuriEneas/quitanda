import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/widgets/custom_text_field.dart';

import '../../../../services/validators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  ForgotPasswordDialog({
    Key? key,
    required String email,
  }) : super(key: key) {
    emailController.text = email;
  }

  final emailController = TextEditingController();
  final formFieldKey = GlobalKey<FormFieldState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Dialog Content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Introduction text
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Subtitle text
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 18),
                  child: Text(
                    'Digite seu email para recuperar a senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

                // Text Field
                CustomTextField(
                  formFieldKey: formFieldKey,
                  labelText: 'E-mail',
                  controller: emailController,
                  icon: Icons.email,
                  validator: validateEmail,
                ),

                // Confirm button
                ElevatedButton(
                  onPressed: () {
                    if (formFieldKey.currentState!.validate()) {
                      authController.resetPassword(emailController.text);
                      Get.back(result: true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Recuperar'),
                ),
              ],
            ),
          ),

          // Icon Button close
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back(result: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
