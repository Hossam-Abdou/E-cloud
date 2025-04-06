import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
final String? title;

const ProductDetailsAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: AppStyles.medium18TextStyle(color: AppColors.textcolor),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.cartRoute);
          },
          icon: const ImageIcon(
            AssetImage(
              AppAssets.cartIcon,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
