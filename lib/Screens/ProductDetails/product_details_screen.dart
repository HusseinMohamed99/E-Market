import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_marko/shared/components/buttons.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is ChangeCartSuccessStates) {
          if (state.model.status!) {
            showToast(
              text: state.model.message!,
              state: ToastStates.success,
            );
          } else {
            showToast(
              text: state.model.message!,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        final scaffoldKey = GlobalKey<ScaffoldState>();
        var cubit = MainCubit.get(context);
        var productModel = cubit.productResponse!.data;
        return Scaffold(
          key: scaffoldKey,
          body: (state is! ProductLoadingStates)
              ? AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.black.withOpacity(0.3),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: productModel!.images!.length,
                        itemBuilder: (context, index, n) {
                          return SizedBox(
                            width: double.infinity,
                            child: ImageWithShimmer(
                              imageUrl: productModel.images![index],
                              width: double.infinity,
                              height: 200.h,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            cubit.onPageChange(index);
                          },
                          autoPlay: true,
                          height: 300.h,
                          viewportFraction: 1,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 320).r,
                          child: AnimatedSmoothIndicator(
                            count: cubit.productResponse!.data!.images!.length,
                            activeIndex: cubit.activeIndex,
                            effect: ExpandingDotsEffect(
                              dotColor: AppMainColors.greyColor,
                              dotHeight: 10.h,
                              dotWidth: 10.w,
                              expansionFactor: 4,
                              spacing: 5,
                              activeDotColor: AppMainColors.redColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 35.0).r,
                        child: CircleAvatar(
                          backgroundColor: AppMainColors.greyColor,
                          radius: 20.r,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              IconBroken.Arrow___Left_2,
                              color: AppMainColors.orangeColor,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: (state is! ProductLoadingStates)
              ? FloatingActionButton(
                  backgroundColor: AppMainColors.whiteColor,
                  onPressed: () {
                    cubit.changeFavorites(cubit.productResponse!.data!.id!);
                  },
                  child: Icon(
                    IconBroken.Heart,
                    color: cubit.favorites[cubit.productResponse!.data!.id]
                        ? Colors.red
                        : Colors.grey,
                    size: 25.sp,
                  ))
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: (state is! ProductLoadingStates)
              ? BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 9.0,
                  elevation: 30.0,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: 390.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cubit.isDark
                          ? AppMainColors.whiteColor
                          : AppColorsDark.primaryDarkColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 20.0, top: 30.0)
                          .r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.productResponse!.data!.name!,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 5.0).r,
                            child: Text(
                              'About',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppMainColors.redColor),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                cubit.productResponse!.data!.description!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${cubit.productResponse!.data!.price} EPG',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: AppMainColors.redColor),
                                    ),
                                    Text(
                                      'Price',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: defaultButton(
                                      color: cubit.isDark
                                          ? AppMainColors.mainColor
                                          : AppMainColors.orangeColor,
                                      context: context,
                                      widget: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MainCubit.get(context)
                                                  .cart[productModel!.id]
                                              ? Text(
                                                  'Add To Cart',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                )
                                              : Text(
                                                  'In Cart',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                          SizedBox(width: 5.w),
                                          Icon(
                                            IconBroken.Buy,
                                            color: AppMainColors.whiteColor,
                                            size: 24.sp,
                                          ),
                                        ],
                                      ),
                                      function: () {
                                        cubit.changeCart(productModel.id!);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
