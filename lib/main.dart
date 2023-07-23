import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/Screens/login/login_screen.dart';
import 'package:super_marko/Screens/on_boarding/on_boarding_screen.dart';
import 'package:super_marko/layout/home_screen.dart';
import 'package:super_marko/network/cache_helper.dart';
import 'package:super_marko/network/dio_helper.dart';
import 'package:super_marko/shared/bloc_observer.dart';
import 'package:super_marko/shared/components/constants.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/enum/enum.dart';
import 'package:super_marko/shared/styles/themes.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(Myapp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class Myapp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const Myapp({Key? key, required this.startWidget, this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MainCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()
              ..getCartData()
              ..getFaqData()),
        BlocProvider(
          create: (context) => MainCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  title: 'Super Marko',
                  theme: getThemeData[AppTheme.lightTheme],
                  darkTheme: getThemeData[AppTheme.darkTheme],
                  themeMode: MainCubit.get(context).isDark
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  debugShowCheckedModeBanner: false,
                  home: startWidget,
                );
              },
            );
          }),
    );
  }
}
