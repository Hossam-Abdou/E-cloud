import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/core/utils/widgets/heart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductItem extends StatelessWidget {
  final String productName;
  final String description;
  final String image;
  final num price;
  final num rating;
  final VoidCallback onPressed;
  final VoidCallback onAddToCart;
  final VoidCallback heartButtonOnTap;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final String? buttonText;
  final String heartIcon;
  final IconData? buttonIcon;

  const CustomProductItem({
    required this.productName,
    required this.description,
    required this.price,
    required this.rating,
    required this.onPressed,
    required this.onAddToCart,
    required this.heartButtonOnTap,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonText,
    this.buttonIcon,
    required this.image,
    required this.heartIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xffacbfd0), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  decoration: BoxDecoration(
                    image:  DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.01,
                    right: MediaQuery.sizeOf(context).width * 0.01,
                    child: HeartButton(onTap:heartButtonOnTap ,heartIcon: heartIcon,),),

                // Positioned(
                //   right: 6,
                //   top: 5,
                //   child: CircleAvatar(
                //     backgroundColor: Colors.white70,
                //     child: ImageIcon(AssetImage(AppAssets.favouriteIcon), color: AppColors.primaryColor,),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 8),

            // Product name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style:AppStyles.regularSize12(color: AppColors.textcolor,fontSize: 14.sp,),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),

                  // Product description
                  Text(
                    description,
                    style:AppStyles.regularSize12(color: AppColors.textcolor,fontSize: 12.sp,),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),

                  // Price and rating row
                  Text(
                    'EGP $price',
                    style:AppStyles.regularSize12(color: AppColors.textcolor,fontSize: 16.sp,),

                  ),
                  // Rating
                  Row(
                    children: [
                      Text(
                        'Review ($rating)',
                        style: AppStyles.regularSize12(
                          color: AppColors.textcolor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.amber, size: 24.sp),
                      const Spacer(),
                      InkWell(
                        onTap: onAddToCart,
                        child: Material(
                          shape: const CircleBorder(),
                          color: AppColors.primaryColor,
                          child: Icon(
                            buttonIcon,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      // FloatingActionButton(
                      //   onPressed: onAddToCart,
                      //   shape: const CircleBorder(),
                      //   backgroundColor: buttonColor ?? Colors.black,
                      //   mini: true,
                      //   child: Icon(
                      //     buttonIcon ?? Icons.add_shopping_cart,
                      //     color: buttonTextColor ?? Colors.white,
                      //     size: 40,
                      //   ),
                      // ),
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
}
