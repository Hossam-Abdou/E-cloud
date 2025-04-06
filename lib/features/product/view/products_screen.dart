import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/bottom_nav_bar/widgets/custom_app_bar.dart';
import 'package:eco_app/features/product/widgets/custom_product_item.dart';
import 'package:eco_app/features/product/view_model/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsScreen extends StatelessWidget {
  final  id;

  const ProductsScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()
        ..getAllProducts(id)
        ..getFavourites(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductAddToFavouriteSuccessState) {
              // Show a SnackBar to indicate success
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added to favorites successfully!',
                    style: AppStyles.medium18TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.primaryColor,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
            if (state is ProductAddToCartSuccess) {
              // Show a SnackBar to indicate success
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added to Cart',
                    style: AppStyles.medium18TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.primaryColor.withOpacity(0.8),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          builder: (context, state) {
            var cubit = ProductCubit.get(context);

            // Handle loading state
            if (state is GetAllProductsLoadingState ||
                state is ProductFavouriteLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            // Handle error state
            if (state is GetAllProductsErrorState) {
              return Center(
                child: Text(
                  'Error',
                  style: AppStyles.medium18TextStyle(),
                ),
              );
            }

            // Handle success state with empty data
            final products = cubit.productModel?.data;
            if (products == null || products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined,
                        size: 50, color: Colors.grey),
                    SizedBox(height: 16.h),
                    Text(
                      'No products available',
                      style: AppStyles.medium18TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            // Render the grid of products
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1 / 1.96,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CustomProductItem(
                    productName: product.title ?? '',
                    description: product.description ?? '',
                    price: product.price ?? 0,
                    rating: product.ratingsAverage ?? 0,
                    image: product.images?.isNotEmpty == true
                        ? product.images!.first
                        : '', // Select the first image
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.productDetails,
                        arguments: product,
                      );
                    },
                    onAddToCart: () {
                      cubit.addToCart(productId: product.id ?? '');
                    },
                    buttonColor: AppColors.primaryColor,
                    buttonIcon: Icons.add,
                    heartButtonOnTap: () {
                      cubit.addToFavourites(productId: product.id ?? '');
                      if (state is ProductAddToFavouriteSuccessState) {

                      }
                    },
                    // heartIcon: AppAssets.favouriteIcon,
                    heartIcon: cubit.favouriteModel?.data?.any((item) =>
                    item.sId == product.id) ==
                        true
                        ? AppAssets.addedToFavouriteIcon
                        : AppAssets.favouriteIcon,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}