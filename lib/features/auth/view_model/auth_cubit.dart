import 'package:dio/dio.dart';
import 'package:eco_app/core/api/api_manager.dart';
import 'package:eco_app/core/api/end_points.dart';
import 'package:eco_app/core/cache/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  bool isVisible = false;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibilityState());
  }

  login() async {
    emit(LoginLoadingState());
    try {
      final response = await ApiManager().postData(
        endPoint: EndPoints.signIn,
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );
      if (response.data['message'] == 'success') {
        emit(LoginSuccessState());
        // Check if token exists before storing
        final token = response.data['token'];
        if (token != null) {
          await SecureStorage().storage.write(key: 'token', value: token);
        }

        debugPrint('The token is: ${await SecureStorage().storage.read(key: 'token')}');
      } else {
        emit(LoginErrorState(response.data['message']));
        // print("Login failed: ${registerModel?.message}");
      }
    } on DioException catch (error) {
      // Handle Dio-specific errors here
      if (error.response != null && error.response?.statusCode == 404) {
        // print(message);
      } else {
        debugPrint('Unexpected Dio error: ${error.toString()}');
      }
      emit(LoginErrorState(error.toString()));
    } catch (error) {
      // Catch any other unexpected errors
      debugPrint('Unexpected error: $error');
      emit(LoginErrorState(error.toString()));
    }
  }

  register() async {
    emit(RegisterLoadingState());
    try {
      final response = await ApiManager().postData(
        endPoint: EndPoints.signUp,
        body: {
          "email": emailController.text,
          "password": passwordController.text,
          "phone": phoneController.text,
          "name": userNameController.text,
          "rePassword": confirmPasswordController.text,
        },
      );

      // Handle successful response
      if (response.statusCode == 201 || response.data['status'] == 'success') {
        final token = response.data['token'];
        if (token != null) {
          await SecureStorage().storage.write(key: 'token', value: token);
        }
        debugPrint('Token: ${await SecureStorage().storage.read(key: 'token')}');
        emit(RegisterSuccessState());
      } else {
        // Handle API-specific error messages
        final errorMessage = response.data['message'] ?? 'Registration failed';
        emit(RegisterErrorState(errorMessage));
      }
    } on DioException catch (error) {
      // Handle Dio-specific errors
      String errorMessage = 'Registration failed';

      if (error.response != null) {
        // Handle 409 Conflict (email exists) or other API errors
        if (error.response?.statusCode == 409) {
          errorMessage = 'Email already exists';
        } else if (error.response?.data != null && error.response?.data['message'] != null) {
          errorMessage = error.response!.data['message'];
        } else if (error.response?.data['errors'] != null) {
          errorMessage = error.response!.data['errors']['msg'] ?? errorMessage;
        }
      }

      debugPrint('Registration error: $errorMessage');
      emit(RegisterErrorState(errorMessage));
    } catch (error) {
      // Handle other errors
      debugPrint('Unexpected error: $error');
      emit(RegisterErrorState('An unexpected error occurred'));
    }
  }
  // Sign Out Method
  Future<void> signOut() async {
    try {
      // Clear the stored token
      await SecureStorage().storage.delete(key: 'token');

      // Reset the text controllers
      emailController.clear();
      passwordController.clear();
      userNameController.clear();
      phoneController.clear();

      // Emit the sign-out state
      emit(SignOutSuccessState());

      debugPrint('User signed out successfully.');
    } catch (error) {
      debugPrint('Error during sign out: $error');
      emit(SignOutErrorState(error.toString()));
    }
  }


}
