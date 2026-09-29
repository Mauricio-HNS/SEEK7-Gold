import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/home_screen.dart';
import '../screens/live_mining_screen.dart';
import '../screens/merchant_dashboard_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/run_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/wallet_screen.dart';

class Seek7Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const auth = '/auth';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const wallet = '/wallet';
  static const run = '/run';
  static const liveRun = '/live-run';
  static const merchant = '/merchant';

  static Map<String, WidgetBuilder> get all => {
        splash: (_) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        auth: (_) => const AuthScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        home: (_) => const HomeScreen(),
        wallet: (_) => const WalletScreen(),
        run: (_) => const RunScreen(),
        liveRun: (_) => const LiveMiningScreen(),
        merchant: (_) => const MerchantDashboardScreen(),
      };
}
