import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    title: Row(
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
        IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
      ],
    ),
  );
}