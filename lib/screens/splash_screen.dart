import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/app_provider.dart';
import '../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        if (provider.isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // App Logo - Piggy bank icon with green background
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.neonGreen,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.savings_outlined,
                  size: 60,
                  color: AppTheme.black,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // App Name
              Text(
                AppConstants.appName,
                style: AppTheme.headingLarge.copyWith(
                  fontSize: 36,
                  letterSpacing: 0.5,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Tagline
              Text(
                AppConstants.appTagline,
                style: AppTheme.bodyMedium.copyWith(
                  fontSize: 16,
                ),
              ),
              
              const Spacer(),
              
              // Version at bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: Text(
                  AppConstants.appVersion,
                  style: AppTheme.bodyMedium.copyWith(
                    fontSize: 14,
                    color: AppTheme.textLightGray,
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
