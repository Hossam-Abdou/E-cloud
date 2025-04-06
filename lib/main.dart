import 'package:eco_app/config/routes_manager/route_generator.dart';
import 'package:eco_app/config/routes_manager/routes.dart';
import 'package:eco_app/core/cache/secure_storage.dart';
import 'package:eco_app/core/cache/shared_pref.dart';
import 'package:eco_app/core/utils/observer.dart';
import 'package:eco_app/features/auth/view_model/auth_cubit.dart';
import 'package:eco_app/features/bottom_nav_bar/view_model/bottom_bar_cubit.dart';
import 'package:eco_app/features/home/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  String? token = await SecureStorage().storage.read(key: 'token');
  debugPrint('Route $token');

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
      ),
      BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..getFavourites(),
      ),

      BlocProvider<BottomBarCubit>(
        create: (context) => BottomBarCubit(),
      )
    ],
    child: MyApp(loggedIn: token==null?false:true,),
  ));
}

class MyApp extends StatelessWidget {
  bool? loggedIn;

  MyApp({super.key,this.loggedIn});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: loggedIn==false?Routes.signInRoute:Routes.bottomNavRoute,
            );
          }
      ),
    );
  }
}


