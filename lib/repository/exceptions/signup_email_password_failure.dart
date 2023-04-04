class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "Um erro desconhecido ocorreu."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "weak-password":
        return const SignUpWithEmailAndPasswordFailure(
            "Por favor, escolha uma senha mais forte.");
      case "invalid-email":
        return const SignUpWithEmailAndPasswordFailure(
            "Por favor, insira um email válido.");
      case "email-already-in-use":
        return const SignUpWithEmailAndPasswordFailure(
            "Este email já está em uso.");
      case "operation-not-allowed":
        return const SignUpWithEmailAndPasswordFailure(
            "O cadastro de usuários está desabilitado. Contate o Suporte");
      case "user-disabled":
        return const SignUpWithEmailAndPasswordFailure(
            "Este usuário está desabilitado. Contate o Suporte");
      default:
        return const SignUpWithEmailAndPasswordFailure(
            "Um erro desconhecido ocorreu.");
    }
  }
}
