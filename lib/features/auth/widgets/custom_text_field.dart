import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
final Color fillColor;
final String? hintText;
final bool isPassword;
 final bool isVisible;
final IconData? suffixIcon;
final VoidCallback? suffixIconOnPress;
final TextEditingController controller;

const CustomTextField({super.key, 
  this.suffixIcon,
  this.isPassword = false,
  this.suffixIconOnPress,
  required this.controller,
  this.isVisible = false,
  this.fillColor = AppColors.white,this.hintText,
});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller:controller ,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        hintText: hintText,
        hintStyle: AppStyles.font300Size18(color: Colors.black.withOpacity(0.7)),

          suffixIcon:IconButton(onPressed: suffixIconOnPress , icon: Icon(suffixIcon),)

      ),
    );
  }
}
