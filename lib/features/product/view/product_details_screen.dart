import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/core/utils/widgets/custom_button.dart';
import 'package:eco_app/features/product/widgets/product_color.dart';
import 'package:eco_app/features/product/widgets/product_counter.dart';
import 'package:eco_app/features/product/widgets/product_size.dart';
import 'package:eco_app/features/product/view_model/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ProductDetailsScreen extends StatelessWidget {
  final productId;

  const ProductDetailsScreen(this.productId, {super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint('the id is  $productId');
    return BlocProvider(
      create: (context) => ProductCubit()..getAllProducts(productId.id.toString()),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductAddToCartSuccess) {
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
PageController controller= PageController();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                productId.title ?? '',
                style: AppStyles.medium18TextStyle(color: AppColors.textcolor),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.cartRoute);
                  },
                  icon: const ImageIcon(
                    AssetImage(
                      AppAssets.cartIcon,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center(
                    //   child: Image.network(
                    //     productId.images[0],
                    //     height: MediaQuery.sizeOf(context).height * 0.44,
                    //     width: double.infinity,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.53,
                          child: PageView.builder(
                            controller: controller,
                            itemCount: productId.images?.length,
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
                            count: productId.images.length,
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
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: Text(productId.title ?? '',
                              style: AppStyles.medium18TextStyle(
                                color: AppColors.textcolor,
                              )),
                        ),
                        Text(
                          'EGP ${productId.priceAfterDiscount ?? productId.price}',
                          style: AppStyles.medium18TextStyle(
                            color: AppColors.textcolor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                    ),
                    Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 5.h),
                          child: Text(
                            '${productId.sold} Sold',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.medium18TextStyle(
                              color: AppColors.textcolor,
                              fontSize: 16.sp
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Image.asset(
                          AppAssets.rateIcon,
                          width: 30.w,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                          child: Text(
                            '${productId.ratingsAverage} (${productId.ratingsQuantity})',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.medium18TextStyle(
                                color: AppColors.textcolor, fontSize: 16.sp),
                          ),
                        ),
                        ProductCounter(
                          add: (_) {
                            cubit.increment();
                          },
                          remove: (_) {
                            cubit.decrement();
                          },
                          productCounter: cubit.generalRepo.counter,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'Description',
                      style: AppStyles.regularSize12(
                          color: AppColors.textcolor, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ReadMoreText(
                      '${productId.description}',
                      style: AppStyles.medium18TextStyle(
                          color: AppColors.textcolor, fontSize: 14.sp),
                      trimExpandedText: ' Read Less',lessStyle:AppStyles.medium18TextStyle(color: AppColors.strokcolor),
                      trimCollapsedText: ' Read More',moreStyle: AppStyles.medium18TextStyle(color: AppColors.strokcolor),
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      colorClickableText: AppColors.textcolor.withOpacity(0.6),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ProductSize(
                      onSelected: () {},
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'Color',
                      style: AppStyles.regularSize12(
                          color: AppColors.textcolor, fontSize: 18.sp),
                    ),
                    ProductColor(
                      onSelected: () {},
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total price',
                                style: AppStyles.medium18TextStyle(
                                  color: AppColors.primaryColor.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                'EGP ${(productId.priceAfterDiscount != null ? productId.priceAfterDiscount! * cubit.generalRepo.counter : productId.price! * cubit.generalRepo.counter)}',
                                style: AppStyles.medium18TextStyle(
                                  color: AppColors.textcolor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 33.w,
                          ),
                          Expanded(
                            child: CustomButton(
                              title: 'Add to cart',
                              color: AppColors.primaryColor,
                              textColor: AppColors.white,
                              isAddToCartButton: true,
                              onPressed: (){
                                cubit.addToCart(productId: productId.id.toString());
                              },
                              buttonWidth: 1,
                            ),
                          ),
                          // Expanded(
                          //   child: CustomElevatedButton(
                          //     label: 'Add to cart',
                          //     onTap: () {},
                          //     prefixIcon: Icon(
                          //       Icons.add_shopping_cart_outlined,
                          //       color: AppColors.white,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
