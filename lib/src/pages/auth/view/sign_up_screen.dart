import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quitanda/src/config/custom_color.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/services/validators.dart';

import '../../../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _key = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  // App Title
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),

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
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Email field
                          CustomTextField(
                            icon: Icons.email,
                            labelText: 'Email',
                            inputType: TextInputType.emailAddress,
                            validator: validateEmail,
                            onSaved: (email) {
                              authController.user.email = email;
                            },
                          ),

                          // Password field
                          CustomTextField(
                            icon: Icons.lock,
                            labelText: 'Senha',
                            isSecret: true,
                            inputType: TextInputType.visiblePassword,
                            validator: validatePassword,
                            onSaved: (pass) {
                              authController.user.password = pass;
                            },
                          ),

                          CustomTextField(
                            icon: Icons.person,
                            labelText: 'Nome',
                            validator: validateName,
                            onSaved: (name) {
                              authController.user.fullname = name;
                            },
                          ),

                          CustomTextField(
                            icon: Icons.phone,
                            labelText: 'Celular',
                            inputFormatters: [phoneFormatter],
                            inputType: TextInputType.number,
                            validator: validatePhone,
                            onSaved: (phone) {
                              authController.user.phoneNumber =
                                  '(99) 99999-9999';
                            },
                          ),

                          CustomTextField(
                            icon: Icons.file_copy,
                            labelText: 'CPF',
                            inputFormatters: [cpfFormatter],
                            inputType: TextInputType.number,
                            validator: validateCpf,
                            onSaved: (cpf) {
                              authController.user.cpf = cpf;
                            },
                          ),

                          Obx(
                            () {
                              return SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();

                                          if (_key.currentState!.validate()) {
                                            _key.currentState!.save();
                                            authController.signUp();
                                          }
                                        },

                                  // Style button
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),

                                  // Text
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Cadastrar Usuário',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Back button
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
