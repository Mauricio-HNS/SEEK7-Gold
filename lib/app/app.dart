import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/wallet_screen.dart';
import '../screens/run_screen.dart';
import '../screens/live_mining_screen.dart';
import '../screens/merchant_dashboard_screen.dart';

class Seek7App extends StatelessWidget {
  const Seek7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEEK7',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080A0D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD6B45A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/auth': (_) => const AuthScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/home': (_) => const HomeScreen(),
        '/wallet': (_) => const WalletScreen(),
        '/run': (_) => const RunScreen(),
        '/live-run': (_) => const LiveMiningScreen(),
        '/merchant': (_) => const MerchantDashboardScreen(),
      },
    );
  }
}
