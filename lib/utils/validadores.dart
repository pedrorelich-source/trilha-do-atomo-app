/// Validações do formulário de cadastro. Retornam a mensagem de erro ou null se o valor for válido.
class Validadores {
  static final _somenteLetras = RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ' ]+$");
  static final _email = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  static String? nome(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe seu nome.';
    if (texto.length < 3) return 'O nome precisa ter pelo menos 3 letras.';
    if (!_somenteLetras.hasMatch(texto)) return 'Use apenas letras no nome.';
    return null;
  }

  static String? email(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe seu e-mail.';
    if (!_email.hasMatch(texto)) return 'E-mail inválido. Exemplo: ana@escola.com';
    return null;
  }

  static String? cidade(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Informe sua cidade.';
    if (texto.length < 2) return 'Cidade muito curta.';
    return null;
  }
}
