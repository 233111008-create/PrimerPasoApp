import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_repository.dart';
import 'core_theme.dart';
import 'custom_button.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthRepository _auth = AuthRepository();
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
    final correo = _correoCtrl.text.trim();
    final contrasena = _contrasenaCtrl.text;
    if (correo.isEmpty || contrasena.isEmpty) {
      setState(() => _error = 'Escribe tu correo y contraseña.');
      return;
    }
    setState(() {
      _cargando = true;
      _error = null;
    });
    try {
      if (_esRegistro) {
        await _auth.registrar(correo, contrasena);
      } else {
        await _auth.iniciarSesion(correo, contrasena);
      }
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = AuthRepository.mensajeDeError(e));
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
                    TextField(
                      controller: _correoCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _contrasenaCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
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
    );
  }
}
