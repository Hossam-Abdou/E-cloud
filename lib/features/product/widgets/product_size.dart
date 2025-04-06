

import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSize extends StatefulWidget {
  final void Function() onSelected;
  const ProductSize({super.key ,  required this.onSelected});

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  List<int> size = [35, 38, 39, 40];
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size',

            style: AppStyles.medium18TextStyle(color: AppColors.textcolor),
        ),
        SizedBox(height: 8.h,),
        SizedBox(
          height: 45.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              itemBuilder: (context , index){
              return GestureDetector(
                onTap: (){
                  setState(() {
                    selected = index;
                  });
                  widget.onSelected;
                },
                child:

                CircleAvatar(
                  radius: 22.r,
                  backgroundColor:
                  index == selected ? AppColors.primaryColor : Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 9.h
                    ),
                    child: Text(
                      '${size[index]}',
                      style:AppStyles.medium18TextStyle(color:index == selected
                      ? AppColors.white
                          : AppColors.textcolor,),
                    ),
                  ),
                ),
              );
              },
              separatorBuilder: (context , index)=>SizedBox(width: 17.w,),
              itemCount: size.length),
        ),
      ],
    );
  }
}
