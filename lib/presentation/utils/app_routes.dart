// app_routes.dart

import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case UpdateProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());
    // Add more routes here if needed
      default:
        return null;
    }
  }
}
