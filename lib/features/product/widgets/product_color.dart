import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductColor extends StatefulWidget {
  final void Function() onSelected;

  const ProductColor(
      {super.key,  required this.onSelected});

  @override
  State<ProductColor> createState() => _ProductColorState();
}

class _ProductColorState extends State<ProductColor> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
     List<Color> color=[
       Colors.red,
       Colors.blueAccent,
       Colors.green,
       Colors.yellow,
     ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 45.h,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                    widget.onSelected.call();
                  },
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: color[index],
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check,
                        color: index == selected
                            ? AppColors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 17.w,
                  ),
              itemCount: color.length),
        ),
      ],
    );
  }
}
