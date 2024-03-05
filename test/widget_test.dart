import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';
import '../utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        // Check if the current screen is UpdateProfileScreen
        if (ModalRoute.of(TaskManager.navigatorKey.currentState!.context)?.settings.name != UpdateProfileScreen.routeName) {
          Navigator.pushNamed(
            TaskManager.navigatorKey.currentState!.context,
            UpdateProfileScreen.routeName,
          );
        }
      },
      child: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rabbil Hasan",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                Text("info@rabbilhasan.com",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                TaskManager.navigatorKey.currentState!.context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    ),
  );
}
