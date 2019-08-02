
class LoginValidators {
  static Function userValidator = (user, sink) {
    if (user.length == 14) {
      sink.add(user.toString().toUpperCase());
    } else {
      sink.addError("Usuário não é válido.");
    }
  };

  static Function passwordValidator = (password, sink) {
    if (password.length == 6 ) {
      sink.add(password);
    } else {
      sink.addError("Senha deve ser maior que 4 carateres.");
    }
  };

}

