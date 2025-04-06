import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends BottomNavigationBarItem {
  @override
  String tittle ;
  String? iconPath;

  CustomBottomBar({required this.tittle, required this.iconPath})
      : super(
            activeIcon: CircleAvatar(
              backgroundColor: Colors.white,
              child: ImageIcon(
                AssetImage(
                  iconPath!,
                ),
                color: AppColors.primaryColor,
              ),
            ),
            icon: ImageIcon(AssetImage(iconPath)),
            label: tittle,
  );
}
