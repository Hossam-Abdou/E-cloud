import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eco_app/core/constants/app_assets.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:eco_app/features/auth/view_model/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eco_app/core/utils/widgets/custom_button.dart';
import 'package:eco_app/features/auth/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is RegisterErrorState)
      {
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

      body: SafeArea(
        child: Padding(
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
                  'User Name',
                  style: AppStyles.medium18TextStyle(),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextField(
                  hintText: 'enter your user name',
                  controller: cubit.userNameController,
                ),

                SizedBox(
                  height: 30.h,
                ),
        
        
                Text(
                  'Mobile Number',
                  style: AppStyles.medium18TextStyle(),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextField(
                  hintText: 'enter your mobile no.',
                  controller: cubit.phoneController,
                ),

                SizedBox(
                  height: 30.h,
                ),
        
        
                Text(
                  'E-mail address',
                  style: AppStyles.medium18TextStyle(),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextField(
                  hintText: 'enter your email address',
                  controller: cubit.emailController,

                ),
                SizedBox(
                  height: 30.h,
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
                  isPassword: cubit.isVisible,
                  suffixIcon: cubit.isVisible ? Icons.visibility : Icons.remove_red_eye_outlined,
                  suffixIconOnPress: () {
                    cubit.changeVisibility();
                  },
                  controller: cubit.passwordController,
                ),

                SizedBox(
                  height: 30.h,
                ),

                Text(
                  'Confirm Password',
                  style: AppStyles.medium18TextStyle(),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextField(
                  hintText: 'Confirm Your Password',
                  controller: cubit.confirmPasswordController,
                ),

                SizedBox(
                  height: 50.h,
                ),
                ConditionalBuilder(
                  condition: state is! RegisterLoadingState,
                  fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellowColor,
                      )),
                  builder: (context) =>   CustomButton(
                    title: 'Sign Up',
                    onPressed: (){
                      cubit.register();
                    },
                  ),
                ),


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
