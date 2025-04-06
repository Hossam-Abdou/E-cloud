import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color color;
  final Color textColor;
  final double buttonWidth;
  final bool isAddToCartButton;
  final bool isCheckOutButton;

  const CustomButton(
      {super.key,
      this.onPressed,
      required this.title,
      this.color = AppColors.white,
      this.textColor = AppColors.primaryColor,
      this.buttonWidth = 1.0,
      this.isAddToCartButton = false,
      this.isCheckOutButton = false,
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all<Size>(
          Size(MediaQuery.of(context).size.width * buttonWidth,
              64.h), // Button width and height
        ),
        backgroundColor: WidgetStatePropertyAll(
          color,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isAddToCartButton? const Icon(
            Icons.add_shopping_cart,
            color: AppColors.white,
          ):const SizedBox.shrink(),
          isAddToCartButton || isCheckOutButton?SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.08,
          ):const SizedBox.shrink(),
          Text(
            title,
            style: AppStyles.semiBold20TextStyle(
              color: textColor,
            ),
          ),
          isCheckOutButton?SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.08,
          ):const SizedBox.shrink(),
          isCheckOutButton?const Icon(
            Icons.arrow_right_alt_outlined,
            color: AppColors.white,
            size: 30,
          ):const SizedBox.shrink(),
        ],
      ),
    );
  }
}
