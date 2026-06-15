import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/services/auth_service.dart';
import '../../widgets/auth/auth_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: SumadColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // Logo
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SumadColors.primaryGradient,
                        boxShadow: [BoxShadow(color: SumadColors.primary.withOpacity(0.3), blurRadius: 20)],
                      ),
                      child: const Center(child: Text('S', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(height: 24),
                    const Text('Welcome Back', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Sign in to continue watching', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15)),
                    const SizedBox(height: 40),

                    // Email
                    AuthTextField(
                      controller: _emailController,
                      hint: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v!.contains('@') ? null : 'Enter valid email',
                    ),
                    const SizedBox(height: 16),

                    // Password
                    AuthTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      prefixIcon: Icons.lock_outlined,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (v) => v!.length >= 6 ? null : 'Min 6 characters',
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/forgot_password'),
                        child: Text('Forgot Password?', style: TextStyle(color: SumadColors.primary)),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        child: _isLoading
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                        Padding(const padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR', style: TextStyle(color: Colors.white.withOpacity(0.5))),
                        ),
                        Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Google Sign In
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          try {
                            await _authService.signInWithGoogle();
                            if (mounted) Navigator.pushReplacementNamed(context, '/home');
                          } catch (e) {
                            if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        },
                        icon: Image.asset('assets/icons/google.png', height: 24),
                        label: const Text('Continue with Google', style: TextStyle(fontSize: 15)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white.withOpacity(0.2)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: TextStyle(color: Colors.white.withOpacity(0.6))),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                          child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
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