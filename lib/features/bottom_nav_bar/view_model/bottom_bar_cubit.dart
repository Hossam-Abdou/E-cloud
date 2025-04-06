
import 'package:eco_app/features/home/view/main_tabs/category/category_screen.dart';
import 'package:eco_app/features/home/view/main_tabs/favourite/favourite_screen.dart';
import 'package:eco_app/features/home/view/main_tabs/home/home_screen.dart';
import 'package:eco_app/features/home/view/main_tabs/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarInitial());
  static BottomBarCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    emit(ChangeIndexState());
  }

  List<Widget> layouts = [
      const HomeScreen(),
      const CategoryScreen(),
      const FavouriteScreen(),
      const ProfileScreen()
  ];
}
