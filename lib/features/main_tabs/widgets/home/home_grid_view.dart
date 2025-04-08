import 'package:cached_network_image/cached_network_image.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/bottom_nav_bar/view_model/bottom_bar_cubit.dart';
import 'package:eco_app/features/main_tabs/view_model/home_cubit.dart';
import 'package:eco_app/features/main_tabs/widgets/home/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = HomeCubit.get(context);

        if (state is CategoryLoadingState) {
          return const CustomShimmer();
        }

        if (cubit.categoriesModel?.data == null || cubit.categoriesModel!.data!.isEmpty) {
          // Show a message if no data is available
          return Center(
            child: Text(
              'No categories available',
              style: AppStyles.regularSize12(color: AppColors.textcolor),
            ),
          );
        }
        return SizedBox(
          height:MediaQuery.sizeOf(context).height * 0.32,
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: cubit.categoriesModel?.data?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,


            ),
            itemBuilder: (context, index) {



              return Column(

                children: [

                  GestureDetector(
                    onTap: (){
                      final bottomBarCubit = context.read<BottomBarCubit>();
                      bottomBarCubit.changeIndex(1);

                    },
                    child: CachedNetworkImage(
                      height: 100.h,
                      width: 95.w,
                      fit: BoxFit.cover,
                      imageUrl: cubit.categoriesModel?.data?[index].image?? '',
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)),
                      errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    cubit.categoriesModel?.data?[index].name ?? 'name',
                    style: AppStyles.regularSize12(
                      color: AppColors.textcolor,

                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
