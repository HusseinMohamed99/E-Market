import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/Screens/cart/cart.dart';
import 'package:super_marko/Screens/search/search.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Super Marko 🛒",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    IconBroken.Search,
                    size: 24.sp,
                    color: AppMainColors.orangeColor,
                  ),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                ),
                IconButton(
                  onPressed: () {
                    MainCubit.get(context).changeAppMode();
                  },
                  icon: Icon(
                    Icons.dark_mode_outlined,
                    size: 24.sp,
                  ),
                )
              ],
            ),
            body: cubit.pages[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppMainColors.orangeColor,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Icon(
                Icons.add_shopping_cart,
                size: 24.sp,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              elevation: 50,
              onTap: (index) {
                cubit.changeNavBar(index);
              },
              activeIndex: cubit.currentIndex,
              icons: const [
                IconBroken.Home,
                IconBroken.Category,
                IconBroken.Heart,
                IconBroken.Setting,
              ],
              activeColor: AppMainColors.orangeColor,
              splashColor: AppMainColors.redColor,
              inactiveColor: AppMainColors.greyColor,
              iconSize: 30.sp,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              leftCornerRadius: 32.r,
              rightCornerRadius: 32.r,
            ),
          ),
        );
      },
    );
  }
}
