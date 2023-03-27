class LoginWithEmailAndPasswordFailure {
  final String message;

  const LoginWithEmailAndPasswordFailure(
      [this.message = "Um erro desconhecido ocorreu."]);

  factory LoginWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "wrong-password":
        return const LoginWithEmailAndPasswordFailure(
            "A senha está incorreta. Por favor, tente novamente.");
      case "invalid-email":
        return const LoginWithEmailAndPasswordFailure(
            "Por favor, insira um email válido.");
      case "user-not-found":
        return const LoginWithEmailAndPasswordFailure(
            "Este email não está em uso. Por favor, cadastre-se.");
      case "operation-not-allowed":
        return const LoginWithEmailAndPasswordFailure(
            "O login de usuários está desabilitado. Contate o Suporte");
      case "user-disabled":
        return const LoginWithEmailAndPasswordFailure(
            "Este usuário está desabilitado. Contate o Suporte");
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}
