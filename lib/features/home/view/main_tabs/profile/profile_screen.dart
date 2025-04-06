import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/auth/view_model/auth_cubit.dart';
import 'package:eco_app/features/home/view/main_tabs/profile/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.signInRoute, (route) => false);
        }
      },
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Welcome hossam',
                style: AppStyles.medium18TextStyle(color: AppColors.primaryColor),
              ),
              Text(
                ' Hossam@mail.com',
                style: AppStyles.medium18TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Your full Name',
                style: AppStyles.medium18TextStyle(color: Colors.black, fontSize: 16.sp),
              ),

              const BuildTextField(
                hint: 'Hossam Abdou Ali',
                borderBackgroundColor: AppColors.strokcolor,
                backgroundColor: AppColors.transparent,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Your E-email',
                style: AppStyles.medium18TextStyle(color: AppColors.black, fontSize: 16),
              ),
              const BuildTextField(
                hint: 'Hossam@mail.com',
                borderBackgroundColor: AppColors.strokcolor,
                backgroundColor: AppColors.transparent,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Your Password',
                style: AppStyles.medium18TextStyle(color: AppColors.black, fontSize: 16),
              ),
              const BuildTextField(
                hint: '*********',
                borderBackgroundColor: AppColors.strokcolor,
                backgroundColor: AppColors.transparent,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Your Mobile Number',
                style: AppStyles.medium18TextStyle(color: AppColors.black, fontSize: 16),
              ),
              const BuildTextField(
                hint: '012456498503',
                borderBackgroundColor: AppColors.strokcolor,
                backgroundColor: AppColors.transparent,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Your Address',
                style: AppStyles.medium18TextStyle(color: AppColors.black, fontSize: 16),
              ),
              const BuildTextField(
                hint: 'Mohandseen',
                borderBackgroundColor: AppColors.strokcolor,
                backgroundColor: AppColors.transparent,
                suffixIcon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),

              Center(
                child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sign Out'),
                        content: const Text('Are you sure you want to sign out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              AuthCubit.get(context).signOut();
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     AuthCubit.get(context).signOut();
              //   },
              //   child: const Text('Sign Out'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
