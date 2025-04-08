import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/main_tabs/widgets/category/custom_category_list_shimmer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/home_cubit.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getCategories(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          final isLoading = state is CategoryLoadingState;
          final isSubLoading = state is SubCategoriesLoadingState;

          return SafeArea(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffedf1f5),
                      border: Border(
                        top: BorderSide(
                            width: 2.w,
                            color: AppColors.primaryColor.withOpacity(0.3)),
                        left: BorderSide(
                            width: 2.w,
                            color: AppColors.primaryColor.withOpacity(0.3)),
                        bottom: BorderSide(
                            width: 2.w,
                            color: AppColors.primaryColor.withOpacity(0.3)),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                    ),
                    child: isLoading
                        ? const CustomCategoryListShimmer()
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: cubit.categoriesModel?.data?.length ?? 0,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  cubit.categoryToggle(index);
                                  cubit.getSubCategories(
                                      cubit.categoriesModel?.data?[index].id);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    color: cubit.isSelected == index
                                        ? AppColors.primaryColor
                                            .withOpacity(0.3)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(2.r),
                                        width: 8.w,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: cubit.isSelected == index
                                              ? AppColors.primaryColor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          cubit.categoriesModel?.data?[index]
                                                  .name ??
                                              '',
                                          style: AppStyles.medium18TextStyle(
                                            color: AppColors.textcolor,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: isSubLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor,),)
                        : (cubit.subCategoryModel?.data?.isNotEmpty ?? false)
                            ? Column(
                                children: [
                                  Text(
                                    cubit.categoriesModel
                                            ?.data?[cubit.isSelected].name ??
                                        '',
                                    style: AppStyles.medium18TextStyle(
                                      color: AppColors.textcolor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: cubit
                                            .subCategoryModel!.data!.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 5.h,
                                          crossAxisSpacing: 10.w,
                                          childAspectRatio: 12 / 29,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.productsScreenRoute,
                                                    arguments: cubit.subCategoryModel!.data![index].category
                                                  );
                                                },
                                                child: Container(
                                                  height: 110.h,

                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    image: const DecorationImage(
                                                      image: AssetImage(
                                                       AppAssets.subCategoryCard,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 6.h),
                                              Text(
                                                cubit.subCategoryModel
                                                        ?.data?[index].name ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  'No subcategories available',
                                  style: AppStyles.medium18TextStyle(
                                    color: AppColors.textcolor,
                                  ),
                                ),
                              ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
