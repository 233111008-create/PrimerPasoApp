import 'package:flutter/material.dart';

import 'app_bootstrap.dart';
import 'app_routes.dart';
import 'auth_repository.dart';
import 'core_theme.dart';
import 'custom_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthRepository _auth = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  final _correoCtrl = TextEditingController();
  final _contrasenaCtrl = TextEditingController();
  bool _esRegistro = false;
  bool _cargando = false;
  String? _error;

  @override
  void dispose() {
    _correoCtrl.dispose();
    _contrasenaCtrl.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _cargando = true;
      _error = null;
    });
    final correo = _correoCtrl.text.trim();
    final contrasena = _contrasenaCtrl.text;
    try {
      if (_esRegistro) {
        await _auth.registrar(correo, contrasena);
      } else {
        await _auth.iniciarSesion(correo, contrasena);
      }
      if (!mounted) return;
      await cargarDatosIniciales(context);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } on AuthException catch (e) {
      setState(() => _error = e.mensaje);
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esRegistro ? 'Crear cuenta' : 'Iniciar sesión'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.sombra,
                      blurRadius: 28,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'img/logo.png',
                      width: 96,
                      height: 96,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.trending_up,
                        size: 80,
                        color: AppColors.primario,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    TextFormField(
                      controller: _correoCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                      validator: (v) {
                        final t = (v ?? '').trim();
                        if (t.isEmpty) return 'Escribe tu correo.';
                        if (!t.contains('@') || !t.contains('.')) {
                          return 'Correo no válido.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextFormField(
                      controller: _contrasenaCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (v) {
                        if ((v ?? '').isEmpty) return 'Escribe tu contraseña.';
                        if (v!.length < 6) return 'Mínimo 6 caracteres.';
                        return null;
                      },
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _error!,
                        style: const TextStyle(color: AppColors.favorito),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    _cargando
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            texto: _esRegistro ? 'Registrarme' : 'Entrar',
                            onPressed: _enviar,
                          ),
                    TextButton(
                      onPressed: _cargando
                          ? null
                          : () => setState(() {
                              _esRegistro = !_esRegistro;
                              _error = null;
                            }),
                      child: Text(
                        _esRegistro
                            ? '¿Ya tienes cuenta? Inicia sesión'
                            : '¿No tienes cuenta? Regístrate',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
