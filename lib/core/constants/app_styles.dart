import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color strokcolor = Color(0x4d004182);
  static const Color textcolor = Color(0xff06004f);
  static const Color primaryColor = Color(0xff004182);
  static const Color descriptionColor = Color(0x9906004f);
  static const Color white = Color(0xffffffff);
  static const Color yellowColor = Color(0xfffedd5b);
  static const Color starColor = Color(0xffFDD835);
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color transparent = Colors.transparent;

}



class AppStyles {





  static  TextStyle regularSize12({Color? color,double fontSize=12}){
    return  TextStyle(
      fontSize: fontSize,
      color: color??AppColors.white,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w400,
    );
  }







static  TextStyle font300Size18({Color? color}){
  return  TextStyle(
    fontSize: 18,
    color: color??AppColors.white,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w300,
  );
}

static  TextStyle semiBold24TextStyle({Color? color}){
  return TextStyle(
    fontSize: 24,
    color:color??AppColors.white,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w600,
  );
}


static  TextStyle semiBold20TextStyle({Color? color}){
  return TextStyle(
    fontSize: 20,
    color:color??AppColors.white,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w600,
  );
}


static  TextStyle medium18TextStyle({Color? color,double fontSize=18}){
  return TextStyle(
    fontSize: fontSize,
    color:color??AppColors.white,
    fontWeight: FontWeight.w500,
  );
}
  static  TextStyle bold18TextStyle({Color? color,double fontSize=18}){
    return TextStyle(
      fontSize: fontSize,
      color:color??AppColors.white,
      fontWeight: FontWeight.w700,
    );
  }

}