import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class  CustomCategoryListShimmer extends StatelessWidget {
  const CustomCategoryListShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 15,
      separatorBuilder: (context, index) =>
          SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10.r),
                  width: 8.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(20.r),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20.h,
                    margin: EdgeInsets.only(right: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
