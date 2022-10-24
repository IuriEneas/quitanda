String authErrorsString(String? error) {
  switch (error) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';

    case 'Invalid session token':
      return 'Token inválido';

    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuário: Nome inválido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar usuário: Celular inválido';

    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar usuário: CPF inválido';

    case 'INVALID_DATA':
      return 'Dados inválidos';

    default:
      return 'Um erro não identificado ocorreu, tente novamente mais tarde';
  }
}
