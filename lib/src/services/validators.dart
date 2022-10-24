import 'package:get/get.dart';

// fuction to validate emails
String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu Email';
  }

  if (!email.isEmail) return 'Digite um email válido';

  return null;
}

// fuction to validate passwords
String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }

  if (password.length < 7) {
    return 'Digite uma senha com pelo menos 7 caracteres';
  }

  return null;
}

// fuction to validate names
String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome!';
  }

  final names = name.split(' ');

  if (names.length == 1) return 'Digite seu nome completo!';

  return null;
}

// fuction to validate cellphone
String? validatePhone(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um nome!';
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um número válido';
  }

  return null;
}

// fuction to validate cpf
String? validateCpf(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite seu cpf!';
  }

  if (!cpf.isCpf) return 'Digite um cpf válido';

  return null;
}
