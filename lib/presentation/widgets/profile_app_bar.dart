import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/update_profile_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';

import '../controller/auth_controller.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: () {
        /// Get.to = Navigator.push
        Get.to(() => const UpdateProfileScreen());
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: (AuthController.userData!.photo != null
                ? MemoryImage(base64Decode(AuthController.userData!.photo!
                    .split('data:image/png;base64,')
                    .last))
                : null),
            // backgroundImage: MemoryImage(base64Decode(AuthController.userData!.photo!)),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                /// Get.offAll = pushAndRemoveUntil
                Get.offAll(() => const SignInScreen());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    ),
  );
}
