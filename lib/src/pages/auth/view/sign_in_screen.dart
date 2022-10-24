import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/config/custom_color.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:quitanda/src/pages/pages_route/app_pages.dart';
import 'package:quitanda/src/services/utils_services.dart';
import 'package:quitanda/src/services/validators.dart';

import '../../../widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        reverse: true,

        // Main Body
        child: SizedBox(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: title(),
              ),

              // Bottom sheet
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),

                // Container Decoration
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),

                // Container Column
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Email field
                      CustomTextField(
                        icon: Icons.email,
                        controller: _emailController,
                        labelText: 'Email',
                        validator: validateEmail,
                      ),

                      // Password field
                      CustomTextField(
                        icon: Icons.lock,
                        controller: _passController,
                        labelText: 'Senha',
                        isSecret: true,
                        validator: validatePassword,
                      ),

                      // Login Button
                      GetX<AuthController>(
                        builder: (controller) {
                          return SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: !controller.isLoading.value
                                  ? () {
                                      FocusScope.of(context).unfocus();

                                      if (_formKey.currentState!.validate()) {
                                        controller.signIn(
                                          email: _emailController.text,
                                          password: _passController.text,
                                        );
                                      } else {
                                        print('Campos não válidos');
                                      }

                                      //Get.offNamed(PagesRoute.baseRoute);
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: !controller.isLoading.value
                                  ? const Text(
                                      'Entrar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )
                                  : const CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),

                      // Esqueceu a senha Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            final bool? result = await showDialog(
                              context: context,
                              builder: (context) {
                                return ForgotPasswordDialog(
                                  email: _emailController.text,
                                );
                              },
                            );

                            if (result ?? false) {
                              utilsServices.showToast(
                                message:
                                    'Um link de recuperação foi enviado ao seu e-mail',
                              );
                            } else {
                              utilsServices.showToast(
                                message: 'E-mail não enviado',
                                isError: true,
                              );
                            }
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                                color: CustomColors.customContrastColor),
                          ),
                        ),
                      ),

                      // Decoration "or"
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Text('or'),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      //Sign up button
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.toNamed(PagesRoute.signUpRoute);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 2, color: Colors.lightGreen),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // App title
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 40),
            children: [
              const TextSpan(
                text: 'Green',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'grocer',
                style: TextStyle(
                  color: CustomColors.customContrastColor,
                ),
              ),
            ],
          ),
        ),

        // Categories Animation
        SizedBox(
          height: 40,
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 30),
            child: AnimatedTextKit(
              repeatForever: true,
              pause: Duration.zero,
              animatedTexts: [
                FadeAnimatedText('Frutas'),
                FadeAnimatedText('Verduras'),
                FadeAnimatedText('Carnes'),
                FadeAnimatedText('Legumes'),
                FadeAnimatedText('Cereais'),
                FadeAnimatedText('Laticíneos'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
