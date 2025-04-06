import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';



class HeartButton extends StatelessWidget {
  final void Function()? onTap;
  String heartIcon = AppAssets.favouriteIcon;
   HeartButton({super.key, required this.onTap, required this.heartIcon});



  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // radius: 25,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap:
        // setState(() {
        //   isClicked = !isClicked;
        //   heartIcon = !isClicked ? AppAssets.favouriteIcon : AppAssets.addedToFavouriteIcon;
        //   widget.onTap?.call();
        // });
        onTap,

      child: Material(
        // borderRadius: BorderRadius.circular(2),
        color: AppColors.white,
        elevation: 2,
        shape: const StadiumBorder(),
        shadowColor: Colors.black,
        child: Padding(
            padding: const EdgeInsets.all(6),
            child: ImageIcon(
              AssetImage(heartIcon),
              color: AppColors.primaryColor,
            )),
      ),
    );
  }
}
