import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Notifications',
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
          body: ListView.separated(
              padding: const EdgeInsets.all(15).r,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 155.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: cubit.isDark
                        ? AppMainColors.mainColor
                        : AppMainColors.greyDarkColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ID :',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              cubit.notificationModel!.data!.data![index].id
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppMainColors.whiteColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Title :',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                cubit.notificationModel!.data!.data![index]
                                    .title!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppMainColors.whiteColor),
                                maxLines: 6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                              'Message :',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                cubit.notificationModel!.data!.data![index]
                                    .message!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: AppMainColors.dividerColor),
                                maxLines: 6,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.h);
              },
              itemCount: cubit.notificationModel!.data!.data!.length),
        );
      },
    );
  }
}
