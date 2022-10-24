import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      // Body
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // Email
          CustomTextField(
            labelText: 'Email',
            icon: Icons.email,
            initialValue: authController.user.email,
            readOnly: true,
          ),

          // Nome
          CustomTextField(
            labelText: 'Nome',
            icon: Icons.person,
            initialValue: authController.user.fullname,
            readOnly: true,
          ),

          // Celular
          CustomTextField(
            labelText: 'Celular',
            icon: Icons.phone,
            initialValue: authController.user.phoneNumber,
            readOnly: true,
          ),

          // Cpf
          CustomTextField(
            labelText: 'CPF',
            icon: Icons.file_copy,
            initialValue: authController.user.cpf,
            readOnly: true,
            isSecret: true,
          ),

          // Botão atualizar senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 2,
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Atualizar senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Atualização de senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Current Password
                    const CustomTextField(
                      labelText: 'Senha atual',
                      icon: Icons.lock,
                      isSecret: true,
                    ),

                    // New password
                    const CustomTextField(
                      labelText: 'Nova senha',
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),

                    // Confirm new password
                    const CustomTextField(
                      labelText: 'Confirmar nova senha',
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),

                    // Button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('1'),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  splashRadius: 22,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
