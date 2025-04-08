import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/core/utils/widgets/custom_button.dart';

import 'package:eco_app/features/auth/view_model/auth_cubit.dart';
import 'package:eco_app/features/auth/widgets/create_account_text.dart';
import 'package:eco_app/features/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.bottomNavRoute, (route) => false);
        }
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   automaticallyImplyLeading: false,
          // ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.1),
                  AppColors.secondaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                       AppAssets.logo,
                        height: 240.h,
                        width: 240.h,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery
                            .sizeOf(context)
                            .width * 0.47,
                        child: Text(
                          "Sign in to your Account",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 28.sp, fontWeight: FontWeight.bold,
                          ),

                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter your email and password to log in ",
                        style: AppStyles.medium18TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'E-mail',
                      style: AppStyles.medium18TextStyle(
                          color: AppColors.primaryColor
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                      hintText: 'enter your email',
                      controller: cubit.emailController,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'Password',
                      style: AppStyles.medium18TextStyle(
                          color: AppColors.primaryColor

                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                      hintText: 'enter your password',
                      controller: cubit.passwordController,
                      isPassword: cubit.isVisible,
                      suffixIcon: cubit.isVisible
                          ? Icons.visibility_off_sharp
                          : Icons.visibility,
                      suffixIconOnPress: () {
                        cubit.changeVisibility();
                      },
                    ),
                    Align(
                      alignment: FractionalOffset.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: AppStyles.font300Size18(
                              color: Colors.grey.shade800,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginLoadingState,
                      fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.yellowColor,
                          )),
                      builder: (context) => CustomButton(
                        title: 'Login',
                        onPressed: () {
                          cubit.login();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const CreateAccountText(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
