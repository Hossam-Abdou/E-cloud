import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCartItem extends StatelessWidget {
  final String productName;

  // final String color;
  final currentPrice;
  final String imageUrl;
  final int quantity;
  final VoidCallback? removeFromCart;

  const CustomCartItem({
    super.key,
    required this.productName,
    // required this.color,
    required this.currentPrice,
    required this.imageUrl,
    required this.quantity,
    required this.removeFromCart
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        margin: const EdgeInsets.all(0),
        width: double.infinity,
        padding: EdgeInsets.only(right: 12.w,top: 10.h,bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.primaryColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [


            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                width: MediaQuery.sizeOf(context).width * 0.3,
                height: MediaQuery.sizeOf(context).height * 0.2,
                imageUrl,


              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          productName,
                          maxLines: 3,
                          style: AppStyles.bold18TextStyle(fontSize: 14.sp,color: AppColors.textcolor),

                        ),
                      ),
                       IconButton(
                         onPressed: removeFromCart, icon:  const ImageIcon(
                         AssetImage(
                           AppAssets.deleteIcon,
                         ),
                         color: AppColors.primaryColor,
                       ),),
                 
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),

                  Row(
                    children: [
                      Text('QTY: $quantity ',style: AppStyles.medium18TextStyle(color: AppColors.textcolor),),
                      const Spacer(),
                      Text('EGP ${currentPrice*quantity}',
                          style: AppStyles.medium18TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16.sp
                          )),
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),

                  // Price with Discount

                  // ProductCounter(add: (_){
                  //   HomeCubit.get(context).incrementCounter();
                  // }, remove: (_){
                  //   HomeCubit.get(context).decrementCounter();
                  // }, productCounter:quantity ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
