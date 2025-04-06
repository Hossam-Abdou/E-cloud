
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/bottom_nav_bar/view_model/bottom_bar_cubit.dart';
import 'package:eco_app/features/bottom_nav_bar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BottomBarCubit.get(context);
        return Scaffold(
          // appBar: const CustomAppBar(),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: BottomNavigationBar(
                backgroundColor: AppColors.primaryColor,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.white,
                showUnselectedLabels: true,
                items: [
                  CustomBottomBar(
                    tittle: '',
                    iconPath: AppAssets.homeIcon,
                  ),
                  CustomBottomBar(
                    tittle: '',
                    iconPath: AppAssets.categoryIcon,
                  ),
                  CustomBottomBar(
                    tittle: '',
                    iconPath: AppAssets.favouriteIcon,
                  ),
                  CustomBottomBar(
                    tittle: '',
                    iconPath: AppAssets.profileIcon,
                  ),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (currentIndex) => cubit.changeIndex(currentIndex),
              ),
            ),
          ),
          body: cubit.layouts[cubit.currentIndex],
        );
      },
    );
  }
}
