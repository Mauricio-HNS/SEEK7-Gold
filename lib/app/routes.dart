import 'package:flutter/material.dart';

import '../features/auth/screens/auth_screen.dart';
import '../features/auth/screens/developer_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/mining/screens/live_mining_screen.dart';
import '../features/merchant/screens/merchant_dashboard_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/mining/screens/run_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/wallet/screens/wallet_screen.dart';

class Seek7Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const auth = '/auth';
  static const developer = '/developer';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const wallet = '/wallet';
  static const run = '/run';
  static const liveRun = '/live-run';
  static const merchant = '/merchant';
  static const profile = '/profile';

  static Map<String, WidgetBuilder> get all => {
        splash: (_) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        auth: (_) => const AuthScreen(),
        developer: (_) => const DeveloperScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        home: (_) => const HomeScreen(),
        wallet: (_) => const WalletScreen(),
        run: (_) => const RunScreen(),
        liveRun: (_) => const RunScreen(),
        merchant: (_) => const MerchantDashboardScreen(),
        profile: (_) => const ProfileScreen(),
      };
}
