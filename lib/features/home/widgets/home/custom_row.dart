import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String title;

  const CustomRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.semiBold20TextStyle(color: AppColors.textcolor),
        ),
        const Spacer(),
        TextButton(
            onPressed: () {},
            child: Text(
              'view all',
              style: AppStyles.regularSize12(
                color: AppColors.textcolor,
              ),
            ))
      ],
    );
  }
}
