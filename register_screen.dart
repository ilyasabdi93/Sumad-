import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/services/auth_service.dart';
import '../../widgets/auth/auth_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await _authService.signUpWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _nameController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification email sent! Please verify your email.')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      }
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
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
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
                    const SizedBox(height: 20),
                    Container(
                      width: 70, height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SumadColors.primaryGradient,
                        boxShadow: [BoxShadow(color: SumadColors.primary.withOpacity(0.3), blurRadius: 20)],
                      ),
                      child: const Center(child: Text('S', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(height: 20),
                    const Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text('Start your streaming journey', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
                    const SizedBox(height: 32),

                    AuthTextField(controller: _nameController, hint: 'Full Name', prefixIcon: Icons.person_outlined, validator: (v) => v!.isEmpty ? 'Required' : null),
                    const SizedBox(height: 14),
                    AuthTextField(controller: _emailController, hint: 'Email', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: (v) => v!.contains('@') ? null : 'Valid email required'),
                    const SizedBox(height: 14),
                    AuthTextField(controller: _passwordController, hint: 'Password', prefixIcon: Icons.lock_outlined, obscureText: _obscurePassword, suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)), validator: (v) => v!.length >= 6 ? null : 'Min 6 characters'),
                    const SizedBox(height: 14),
                    AuthTextField(controller: _confirmPasswordController, hint: 'Confirm Password', prefixIcon: Icons.lock_outlined, obscureText: _obscureConfirm, suffixIcon: IconButton(icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off, color: Colors.grey), onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm)), validator: (v) => v == _passwordController.text ? null : 'Passwords do not match'),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        child: _isLoading
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?', style: TextStyle(color: Colors.white.withOpacity(0.6))),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                          child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
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