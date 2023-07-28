import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/generated/assets.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: Icon(
            IconBroken.Arrow___Left_Circle,
            size: 24.sp,
            color: MainCubit.get(context).isDark
                ? AppMainColors.orangeColor
                : AppMainColors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 20).r,
              child: CircleAvatar(
                maxRadius: 102.r,
                minRadius: 102.r,
                backgroundColor: MainCubit.get(context).isDark
                    ? AppColorsDark.primaryDarkColor
                    : AppMainColors.dividerColor,
                child: CircleAvatar(
                  maxRadius: 99.r,
                  minRadius: 99.r,
                  backgroundColor: MainCubit.get(context).isDark
                      ? AppColorsDark.primaryDarkColor
                      : AppMainColors.mainColor,
                  child: Image.asset(
                    Assets.imagesLogo,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Text(
              'About Us',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10.h),
            Container(
              padding: const EdgeInsets.all(4).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15).r,
                border: Border.all(
                  color: MainCubit.get(context).isDark
                      ? AppColorsDark.primaryDarkColor
                      : AppMainColors.mainColor,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16).r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  border: Border.all(
                    color: AppMainColors.orangeColor,
                  ),
                ),
                child: Text(
                  'This is a Shop Application. This app connects to the APIS to show products, search products by name, add/Remove to/From favorites and cart, and edit profile information.'
                  '\n\nFeatures :'
                  '\n - Apis'
                  '\n - State Management (Bloc/Cubit)'
                  '\n - Shared Preferences'
                  '\n - Responsive UI'
                  '\n - MVVM'
                  '\n - Theme Mode',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
