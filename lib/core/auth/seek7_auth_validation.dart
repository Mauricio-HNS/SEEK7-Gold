class Seek7AuthValidation {
  static String? name(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Informe seu nome.';
    if (text.runes.length < 2) return 'O nome deve ter pelo menos 2 caracteres.';
    if (text.runes.length > 100) return 'O nome é muito longo.';
    if (_hasControlCharacters(text)) return 'O nome contém caracteres inválidos.';
    if (!RegExp(r'\p{L}', unicode: true).hasMatch(text)) {
      return 'Informe um nome válido.';
    }
    return null;
  }

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Informe seu e-mail.';
    if (text.length > 254) return 'O e-mail é muito longo.';
    if (_hasWhitespace(text) || _hasControlCharacters(text)) {
      return 'Informe um e-mail válido.';
    }
    final at = text.lastIndexOf('@');
    if (at <= 0 || at != text.indexOf('@') || at == text.length - 1) {
      return 'Informe um e-mail válido.';
    }
    final local = text.substring(0, at);
    final domain = text.substring(at + 1);
    if (local.length > 64 || domain.isEmpty || !domain.contains('.')) {
      return 'Informe um e-mail válido.';
    }
    if (local.startsWith('.') || local.endsWith('.') || local.contains('..')) {
      return 'Informe um e-mail válido.';
    }
    if (domain.startsWith('.') || domain.endsWith('.') || domain.contains('..')) {
      return 'Informe um e-mail válido.';
    }
    return null;
  }

  static String? password(String? value) {
    final text = value ?? '';
    if (text.isEmpty) return 'Informe uma senha.';
    if (text.runes.length < 8) return 'A senha deve ter pelo menos 8 caracteres.';
    if (text.runes.length > 128) return 'A senha é muito longa.';
    if (_hasControlCharacters(text)) return 'A senha contém caracteres inválidos.';
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirme sua senha.';
    if (value != password) return 'As senhas não coincidem.';
    return null;
  }

  static bool _hasLetter(String text) {
    for (final rune in text.runes) {
      final char = String.fromCharCode(rune);
      if (RegExp(r'[A-Za-zÀ-ÖØ-öø-ÿ]').hasMatch(char) ||
          (rune >= 0x100 && !RegExp(r'[0-9]').hasMatch(char))) {
        return true;
      }
    }
    return false;
  }

  static bool _hasWhitespace(String text) =>
      text.runes.any((rune) => rune == 0x20 || rune == 0x09 || rune == 0x0A || rune == 0x0D);

  static bool _hasControlCharacters(String text) =>
      text.runes.any((rune) => (rune < 0x20 && rune != 0x09) || rune == 0x7F);
}

