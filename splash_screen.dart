import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/theme_manager.dart';
import '../../router/app_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/splash';
  
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRouter.home);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6B00),
              Color(0xFFE65100),
              Color(0xFF1A1A1A),
              Color(0xFF0D0D0D),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Container
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SumadColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: SumadColors.primary.withOpacity(0.4),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: SumadColors.textPrimary,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // App Name
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'SUMAD',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: SumadColors.textPrimary,
                    letterSpacing: 8,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Watch. Stream. Enjoy.',
                  style: TextStyle(
                    fontSize: 16,
                    color: SumadColors.textSecondary,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Loading Indicator
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      SumadColors.primary.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}