import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/constants/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccountText extends StatelessWidget {
  const CreateAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account? ',
              style: AppStyles.font300Size18(
                color: Colors.grey.shade800,
              ),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, Routes.signUpRoute);
                },
              text: 'Create Account',
              style: AppStyles.semiBold20TextStyle(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
