
import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // This removes the back arrow
      backgroundColor: Colors.transparent,
      title: const Text('E-Commerce'),
      bottom: PreferredSize(
        preferredSize: Size(100.w, 60.h),
        child: Padding(
          padding: EdgeInsets.all(17.r),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    prefixIcon: const ImageIcon(
                      AssetImage(AppAssets.searchIcon),
                      color: AppColors.primaryColor,
                    ),
                    hintText: "what do you search for?",
                    iconColor: AppColors.primaryColor,
                    hintStyle: AppStyles.regularSize12(
                      color: AppColors.textcolor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Routes.cartRoute);
                },
                child: const ImageIcon(
                  AssetImage(
                    AppAssets.cartIcon,
                  ),
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(152.h);

}
