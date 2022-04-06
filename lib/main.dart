// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/cubit.dart';
import 'package:untitled1/layout/shop_app/shop_layout.dart';
import 'package:untitled1/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled1/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:untitled1/shared/bloc_observer.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/cubit/cubit.dart';
import 'package:untitled1/shared/cubit/states.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';
import 'package:untitled1/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'modules/social_app/social_login/social_login_screen.dart';

void main() async {
  // يتأكد ان كل حاجه هنا في المثود خلصت وبعدين يفتح الأبلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  print("onBoarding = $onBoarding");
  bool isDark = CacheHelper.getData(key: 'isDark');
  print("isDark = $isDark");
  token = CacheHelper.getData(key: 'token');
  print('token = $token');
  Widget widget;
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  ;
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getScience()
            ..getSports(),
        ),
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategeries()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            ////////////////
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
           // home: startWidget,
            home: SocialLoginScreen(),
          );
        },
      ),
    );
  }
}
