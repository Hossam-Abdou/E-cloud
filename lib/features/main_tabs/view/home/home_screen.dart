
import 'package:eco_app/features/bottom_nav_bar/widgets/custom_app_bar.dart';
import 'package:eco_app/features/main_tabs/view_model/home_cubit.dart';
import 'package:eco_app/features/main_tabs/widgets/home/custom_row.dart';
import 'package:eco_app/features/main_tabs/widgets/home/custom_slider.dart';
import 'package:eco_app/features/main_tabs/widgets/home/home_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomeCubit()..getCategories(),
      child: Scaffold(
          appBar: const CustomAppBar(),
          // appBar: AppBar(
          //   title: const Text('Home'),
          //   automaticallyImplyLeading: false,
          // ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: const Column(
                children: [
                 CustomSlider(),
                  CustomRow(
                    title: 'Categories',
                  ),
                  HomeGridView(),
                ],
              ),
            ),
          )),
    );
  }
}
