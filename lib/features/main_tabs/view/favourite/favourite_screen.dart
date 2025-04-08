import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/main_tabs/view_model/home_cubit.dart';
import 'package:eco_app/features/main_tabs/widgets/favourite/custom_empty_favourites.dart';
import 'package:eco_app/features/main_tabs/widgets/favourite/custom_favourite_card.dart';
import 'package:eco_app/features/product/view_model/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getFavourites()),
        BlocProvider(create: (context) => ProductCubit()),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        // listener: (context, state) {
        //   if (state is DeleteFromFavouritesSuccessState) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text(
        //           'Removed from favorites',
        //           style: AppStyles.medium18TextStyle(color: Colors.white),
        //         ),
        //         backgroundColor: AppColors.primaryColor,
        //         duration: const Duration(seconds: 2),
        //       ),
        //     );
        //
        //   }
        // },
        builder: (BuildContext context, state) {
          var favouriteCubit = HomeCubit.get(context);
          var productCubit = ProductCubit.get(context);

          // Handle loading state
          if (state is FavouriteLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          // Handle empty state
          if (favouriteCubit.favouriteModel?.data == null ||
              favouriteCubit.favouriteModel!.data!.isEmpty) {
            return const CustomEmptyFavourites();
          }

          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: 20.h,
            ),
            itemCount: favouriteCubit.favouriteModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return CustomFavouriteCard(
                              productName: favouriteCubit.favouriteModel?.data?[index].title ?? '',
                              removeFromFavourite: () {
               favouriteCubit.deleteFromFavourites(
                productId:  favouriteCubit.favouriteModel?.data?[index].id ?? ''
               );
                              },
                              currentPrice: favouriteCubit.favouriteModel?.data?[index].price ?? '',
                              imageUrl: favouriteCubit.favouriteModel?.data?[index].imageCover ?? '',
                              onAddToCart: () {
                                productCubit.addToCart(
                                  productId: favouriteCubit.favouriteModel?.data?[index].id ?? '',
                                );
                              },
                              heartIcon: favouriteCubit.favouriteModel!.data!.any((item) =>
                     item.sId == productCubit.productModel?.data?[index].id)
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
