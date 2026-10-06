import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/auth/seek7_auth_validation.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool login = false;
  bool loading = false;
  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<String> _hashPassword(String value) async {
    return sha256.convert(utf8.encode(value)).toString();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text.trim().toLowerCase();
    final passwordHash = await _hashPassword(_passwordController.text);

    if (login) {
      final savedEmail = prefs.getString('seek7_account_email');
      final savedHash = prefs.getString('seek7_account_password_hash');

      if (savedEmail != email || savedHash != passwordHash) {
        if (!mounted) return;
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou senha incorretos.')),
        );
        return;
      }
    } else {
      final existingEmail = prefs.getString('seek7_account_email');
      if (existingEmail == email) {
        if (!mounted) return;
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Este e-mail já possui uma conta.')),
        );
        return;
      }

      await prefs.setString('seek7_account_name', _nameController.text.trim());
      await prefs.setString('seek7_account_email', email);
      await prefs.setString('seek7_account_password_hash', passwordHash);
    }

    await prefs.setBool('seek7_logged_in', true);

    if (!mounted) return;
    setState(() => loading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Seek7Colors.gold,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Seek7Colors.navy,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Text(
                      'SEEK7',
                      style: TextStyle(
                        color: Seek7Colors.navy,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 54),
                Text(
                  login ? 'ENTRAR NO SEEK7' : 'CRIAR CONTA',
                  style: const TextStyle(
                    color: Seek7Colors.navy,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  login
                      ? 'Entre na sua conta e continue de onde parou.'
                      : 'Uma conta. Várias possibilidades. Encontre, ganhe ou divulgue.',
                  style: const TextStyle(
                    color: Seek7Colors.muted,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),
                if (!login) ...[
                  _field(
                    'Nome',
                    Icons.person_outline,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    enableSuggestions: false,
                    enableIMEPersonalizedLearning: false,
                    smartDashesType: SmartDashesType.disabled,
                    smartQuotesType: SmartQuotesType.disabled,
                    validator: Seek7AuthValidation.name,
                  ),
                  const SizedBox(height: 13),
                ],
                _field(
                  'E-mail',
                  Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  validator: Seek7AuthValidation.email,
                ),
                const SizedBox(height: 13),
                _field(
                  'Senha',
                  Icons.lock_outline,
                  controller: _passwordController,
                  obscure: obscurePassword,
                  textInputAction: login ? TextInputAction.done : TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  validator: Seek7AuthValidation.password,
                  suffixIcon: IconButton(
                    onPressed: () => setState(
                      () => obscurePassword = !obscurePassword,
                    ),
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                if (!login) ...[
                  const SizedBox(height: 13),
                  _field(
                    'Confirmar senha',
                    Icons.lock_reset_outlined,
                    controller: _confirmController,
                    obscure: obscureConfirm,
                    validator: (value) => Seek7AuthValidation.confirmPassword(
                      value,
                      _passwordController.text,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                        () => obscureConfirm = !obscureConfirm,
                      ),
                      icon: Icon(
                        obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ],
                if (login)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/forgot-password'),
                      child: const Text('Esqueci minha senha'),
                    ),
                  ),
                const SizedBox(height: 14),
                GoldButton(
                  label: loading
                      ? 'AGUARDE...'
                      : (login ? 'ENTRAR' : 'CRIAR MINHA CONTA'),
                  onPressed: loading ? null : () { _submit(); },
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: loading
                        ? null
                        : () {
                            _formKey.currentState?.reset();
                            setState(() => login = !login);
                          },
                    child: Text(
                      login ? 'Criar minha conta' : 'Já tenho uma conta  →  Entrar',
                    ),
                  ),
                ),
                if (!login) ...[
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Seek7Colors.blueLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.bolt_rounded,
                          color: Seek7Colors.gold,
                          size: 28,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'UMA CONTA. MUITAS POSSIBILIDADES.',
                          style: TextStyle(
                            color: Seek7Colors.navy,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: .6,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Encontre oportunidades, ganhe recompensas ou divulgue o que quiser. Você escolhe como usar o SEEK7.',
                          style: TextStyle(
                            color: Seek7Colors.navy,
                            fontSize: 13,
                            height: 1.45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    IconData icon, {
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscure = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    bool autocorrect = false,
    bool enableSuggestions = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      textCapitalization: textCapitalization,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Seek7Colors.navy),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Seek7Colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Seek7Colors.blueLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Seek7Colors.blueLight),
        ),
      ),
    );
  }
}
