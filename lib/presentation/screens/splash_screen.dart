import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controller/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    bool loginState = await AuthController.isUserLoggedIn();

    if (mounted) {
      if (loginState) {
        Get.offAll(() => const MainBottomNavScreen());
      } else {
        Get.offAll(() => const SignInScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
