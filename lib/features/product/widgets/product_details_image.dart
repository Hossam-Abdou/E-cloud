import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsImage extends StatelessWidget {
final int pageViewCount;
final int indicatorCount;
final productId;

ProductDetailsImage({required this.pageViewCount,required this.indicatorCount,this.productId});

@override
  Widget build(BuildContext context) {
    PageController controller= PageController();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.53,
          child: PageView.builder(
            controller: controller,
            itemCount:pageViewCount ,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.strokcolor, ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    productId.images?[index] ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),

        Padding(
          padding:  EdgeInsets.only(bottom: 8.h),
          child: SmoothPageIndicator(
            controller: controller,
            count: indicatorCount,
            axisDirection: Axis.horizontal,
            effect: CustomizableEffect(

              dotDecoration: DotDecoration(
                height: 15.h,
                width: 15.w,
                dotBorder: const DotBorder(color: AppColors.primaryColor,),
                borderRadius: BorderRadius.circular(10.r),
              ),
              activeDotDecoration:DotDecoration(
                height: 15.h,
                width: 35.w,
                dotBorder: const DotBorder(color: AppColors.primaryColor,),
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.primaryColor,
              ),

              // dotWidth: 24.0,
              // dotHeight: 16.0,
              // dotColor: Colors.white,
              // activeDotColor: AppColors.primaryColor,

            ),
          ),
        ),
      ],
    );
  }
}
