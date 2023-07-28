import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/Screens/AboutUs/about_us_screen.dart';
import 'package:super_marko/Screens/Complaints/complaints_screen.dart';
import 'package:super_marko/Screens/FAQS/faqs_screen.dart';
import 'package:super_marko/Screens/Notifications/notifications_screen.dart';
import 'package:super_marko/Screens/Orders/my_orders_screen.dart';
import 'package:super_marko/Screens/Password/change_password.dart';
import 'package:super_marko/Screens/ProfileScreen/profile_screen.dart';
import 'package:super_marko/shared/components/logout.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, const ProfileScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Profile,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'My Profile',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const NotificationsScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Notification,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Notifications',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const OrdersScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Bag,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'My Orders',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    bottomSheetChangePassword(
                        context: context, cubit: MainCubit.get(context));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Password,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Change Password',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const ComplaintsScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Document,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Complaints',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.topSlide,
                      title: 'Do you want to change mode?',
                      btnOkOnPress: () {
                        MainCubit.get(context).changeAppMode();
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Theme Mode',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const FaqScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Bookmark,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'FAQS',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateTo(context, const AboutUsScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Info_Circle,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'About us',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.rightSlide,
                      title: 'Do you want to Logout ?',
                      desc: "Please, Login soon 🤚",
                      btnOkOnPress: () {
                        logOut(context);
                        MainCubit.get(context).currentIndex = 0;
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15).r,
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Logout,
                          color: AppMainColors.orangeColor,
                          size: 35.sp,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Log Out',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
