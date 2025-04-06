import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/bottom_nav_bar/widgets/custom_app_bar.dart';
import 'package:eco_app/features/home/view_model/home_cubit.dart';
import 'package:eco_app/features/home/widgets/custom_row.dart';
import 'package:eco_app/features/home/widgets/home_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    final List<String> adsImages = [
      AppAssets.firstSlider,
      AppAssets.secondSlider,
      AppAssets.thirdSlider,
    ];
    return BlocProvider(
      create: (context) => HomeCubit()..getCategories(),
      child: Scaffold(
          appBar: const CustomAppBar(),
          // appBar: AppBar(
          //   title: const Text('Home'),
          //   automaticallyImplyLeading: false,
          // ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  Stack(
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
                  ),

                  const CustomRow(
                    title: 'Categories',
                  ),
                  const HomeGridView(),
                ],
              ),
            ),
          )),
    );
  }
}
