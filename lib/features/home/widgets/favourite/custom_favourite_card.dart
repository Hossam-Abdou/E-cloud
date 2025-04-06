import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/core/utils/widgets/heart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFavouriteCard extends StatelessWidget {
  final String productName;
  final String heartIcon;

  // final String color;
  final currentPrice;
  final VoidCallback onAddToCart;
  final VoidCallback removeFromFavourite;
  final String imageUrl;

  const CustomFavouriteCard({
    super.key,
    required this.productName,
    required this.removeFromFavourite,
    // required this.color,
    required this.currentPrice,
    required this.onAddToCart,
    required this.imageUrl,
    required this.heartIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        margin: const EdgeInsets.all(0),
        width: double.infinity,
        padding: EdgeInsets.only(right: 12.w),
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
                          style: AppStyles.medium18TextStyle(
                            color: AppColors.textcolor,

                          )
                        ),
                      ),
                      HeartButton(
                        onTap: removeFromFavourite,
                        heartIcon: heartIcon,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),

                  Row(
                    children: [
                      Text('EGP ${currentPrice.toStringAsFixed(0)}',
                          style: AppStyles.medium18TextStyle(
                            color: AppColors.textcolor,
                          )),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.24,
                        child: ElevatedButton(
                          onPressed: onAddToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          child: Text('Add to Cart',
                              style: AppStyles.bold18TextStyle(fontSize: 14.sp)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper function to convert color string to Color
// Color _getColorFromString(String color) {
//   switch (color.toLowerCase()) {
//     case 'black':
//       return Colors.black;
//     case 'red':
//       return Colors.red;
//     case 'blue':
//       return Colors.blue;
//     // Add more color cases as needed
//     default:
//       return Colors.grey;
//   }
// }
}
