import 'package:get/get.dart';
import 'package:quitanda/src/constants/storage_keys.dart';
import 'package:quitanda/src/models/user_model.dart';
import 'package:quitanda/src/pages/auth/repository/auth_repository.dart';
import 'package:quitanda/src/pages/pages_route/app_pages.dart';
import 'package:quitanda/src/services/utils_services.dart';

import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    validateToken();
  }

  void saveTokenAndProceedToBase() {
    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    Get.offAllNamed(PagesRoute.baseRoute);
  }

  void signOut() async {
    user = UserModel();

    await utilsServices.deleteLocalData(key: StorageKeys.token);

    Get.offAllNamed(PagesRoute.signInRoute);
    utilsServices.showToast(message: 'Saiu');
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (error) {
        utilsServices.showToast(
          message: error,
          isError: true,
        );
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(
      email: email,
      password: password,
    );

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (error) {
        utilsServices.showToast(
          message: error,
          isError: true,
        );
      },
    );
  }

  Future<void> validateToken() async {
    // Recuperar Token Criado em login
    String? token = await utilsServices.readLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offNamed(PagesRoute.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (error) {
        signOut();
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}
