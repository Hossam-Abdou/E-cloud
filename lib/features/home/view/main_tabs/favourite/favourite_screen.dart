import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/home/view_model/home_cubit.dart';
import 'package:eco_app/features/home/widgets/custom_favourite_card.dart';
import 'package:eco_app/features/product/view_model/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getFavourites(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          var favouriteCubit = HomeCubit.get(context);

          // Handle loading state
          if (state is FavouriteLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          // Handle empty state
          if (favouriteCubit.favouriteModel?.data == null ||
              favouriteCubit.favouriteModel!.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.favouriteIcon,
                      width: 120.w,
                      height: 120.w,
                      fit: BoxFit.contain,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'No Favorites Yet',
                      style: AppStyles.medium18TextStyle(
                        color: AppColors.textcolor,
                        fontSize: 20.sp, // Slightly larger for emphasis
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Tap the heart icon on products to save them here',
                      style: AppStyles.regularSize12(
                        color: Colors.grey,
                        fontSize: 14.sp, // More readable
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: 20.h,
            ),
            itemCount: favouriteCubit.favouriteModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return CustomFavouriteCard(
                productName:
                    favouriteCubit.favouriteModel?.data?[index].title ?? '',
                removeFromFavourite: () {
                  favouriteCubit.deleteFromFavourites(
                   productId:  favouriteCubit.favouriteModel?.data?[index].id ?? ''
                  );
                },
                currentPrice:
                    favouriteCubit.favouriteModel?.data?[index].price ?? '',
                imageUrl:
                    favouriteCubit.favouriteModel?.data?[index].imageCover ??
                        '',
                onAddToCart: () {},
                heartIcon: favouriteCubit.favouriteModel!.data!.any((item) =>
                        item.sId == ProductCubit.get(context).productModel?.data?[index].id)
                    ? AppAssets.favouriteIcon
                    : AppAssets.addedToFavouriteIcon,
              );
            },
          );
        },
      ),
    );
  }
}
