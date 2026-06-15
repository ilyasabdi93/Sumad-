import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_manager.dart';
import '../../../core/services/auth_service.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _sent = false;

  Future<void> _sendResetEmail() async {
    if (_emailController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    try {
      await _authService.sendPasswordResetEmail(_emailController.text.trim());
      setState(() => _sent = true);
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
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SumadColors.backgroundDark,
      appBar: AppBar(title: const Text('Reset Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _sent
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 80),
                    const SizedBox(height: 24),
                    const Text('Email Sent!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text('Check your email for the password reset link', style: TextStyle(color: Colors.white.withOpacity(0.6), textAlign: TextAlign.center)),
                    const SizedBox(height: 32),
                    ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Back to Sign In')),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Forgot Password?', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Enter your email and we'll send you a reset link", style: TextStyle(color: Colors.white.withOpacity(0.6))),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _sendResetEmail,
                        child: _isLoading
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Send Reset Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}