import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEmptyFavourites extends StatelessWidget {
  const CustomEmptyFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.favouriteIcon,
              width: 120.w,
              height: 120.w,
              fit: BoxFit.contain,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 24.h),
            Text(
              'No Favorites Yet',
              style: AppStyles.medium18TextStyle(
                color: AppColors.textcolor,
                fontSize: 20.sp, // Slightly larger for emphasis
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Tap the heart icon on products to save them here',
              style: AppStyles.regularSize12(
                color: Colors.grey,
                fontSize: 14.sp, // More readable
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
