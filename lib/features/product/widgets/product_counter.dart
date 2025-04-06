
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCounter extends StatelessWidget {
  final int productCounter;
  final void Function(int) add;
  final void Function(int) remove;

  const ProductCounter(
      {super.key,
      required this.add,
      required this.remove,
      required this.productCounter});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.34,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  remove.call(productCounter);
                },
                child: Icon(
                  Icons.remove_circle_outline,
                  size: 20.w,
                  color: AppColors.white,
                )),
            SizedBox(
              width: 18.w,
            ),
            Text(
              '$productCounter',
              style: AppStyles.medium18TextStyle(color: AppColors.white)
                  .copyWith(fontSize: 18.sp),
            ),
            SizedBox(
              width: 18.w,
            ),
            InkWell(
                onTap: () {
                  add.call(productCounter);
                },
                child: Icon(
                  Icons.add_circle_outline,
                  color: AppColors.white,
                  size: 20.w,
                )),
          ],
        ),
      ),
    );
  }
}
