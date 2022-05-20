// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/cart/cart.dart';
import 'package:mego_market/Screens/search/search.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/model/home/home_model.dart';
import 'package:mego_market/shared/componnetns/components.dart';
import 'package:mego_market/shared/mode_cubit/cubit.dart';
import 'package:mego_market/shared/styles/icon_broken.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ProductModel model;
        var cubit = MainCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.add_shopping_cart_sharp),
              title: Text("E_Commerce"),
              actions: [
                IconButton(
                  icon: Icon(
                    IconBroken.Search,
                    color: Colors.deepOrangeAccent,
                  ),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                ),
                IconButton(
                  onPressed: () {
                    ModeCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.dark_mode_outlined),
                )
              ],
            ),
            body: cubit.pages[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Icon(
                Icons.add_shopping_cart,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              elevation: 50.0,
              onTap: (index) {
                cubit.ChangeNavBar(index);
              },
              activeIndex: cubit.currentIndex,

              icons: [
                IconBroken.Home,
                IconBroken.Category,
                IconBroken.Heart,
                IconBroken.Setting,
              ],
              activeColor: Colors.deepOrangeAccent,
              splashColor: Colors.red,
              inactiveColor: Colors.black,
              iconSize: 30.0,
              //backgroundColor: Colors.grey[200],
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.smoothEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
            ),
          ),
        );
      },
    );
  }
}
