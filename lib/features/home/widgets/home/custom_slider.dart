import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {


    PageController controller = PageController();
    final List<String> adsImages = [
      AppAssets.firstSlider,
      AppAssets.secondSlider,
      AppAssets.thirdSlider,
    ];

    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: PageView.builder(
            controller: controller,
            itemCount: adsImages.length,
            itemBuilder: (context, index) {
              return Image.asset(adsImages[index], fit: BoxFit.cover);
            },
          ),
        ),
        Center(
          child: Padding(
            padding:  EdgeInsets.only(bottom: 9.h),
            child: SmoothPageIndicator(
              controller: controller,
              count: adsImages.length,
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: AppColors.white,
                activeDotColor: AppColors.primaryColor,
              ), // your preferred effect
            ),
          ),
        ),
      ],
    );
  }
}
