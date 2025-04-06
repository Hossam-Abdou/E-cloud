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
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Image.asset(
                    AppAssets.logo,
                    height: 85.h,
                  )),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'Welcome Back To Route',
                    style: AppStyles.semiBold24TextStyle(),
                  ),
                  Text(
                    'Please sign in with your mail',
                    style: AppStyles.font300Size18(),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'E-mail',
                    style: AppStyles.medium18TextStyle(),
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
                    style: AppStyles.medium18TextStyle(),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextField(
                    hintText: 'enter your password',
                    controller: cubit.passwordController,
                    isPassword: cubit.isVisible,
                    suffixIcon: cubit.isVisible
                        ? Icons.visibility
                        : Icons.visibility_off_sharp,
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
                          style: AppStyles.font300Size18(),
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
        );
      },
    );
  }
}
