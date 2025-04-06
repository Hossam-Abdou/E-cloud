import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/features/auth/view/login_screen.dart';
import 'package:eco_app/features/auth/view/register_screen.dart';
import 'package:eco_app/features/bottom_nav_bar/view/bottom_bar_screen.dart';
import 'package:eco_app/features/cart/view/cart_screen.dart';
import 'package:eco_app/features/home/view/main_tabs/home/home_screen.dart';
import 'package:eco_app/features/product/view/product_details_screen.dart';
import 'package:eco_app/features/product/view/products_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.bottomNavRoute:
        return MaterialPageRoute(builder: (_) => const BottomBarScreen());

      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.productsScreenRoute:
        return MaterialPageRoute(builder: (_) => ProductsScreen(settings.arguments as String));
      case Routes.productDetails:
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen(settings.arguments));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
