import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_marko/Screens/ProductDetails/product_details_screen.dart';
import 'package:super_marko/generated/assets.dart';
import 'package:super_marko/model/category/category_details_model.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryProductsScreen(this.categoryName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is ChangeFavoritesSuccessStates) {
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
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 24.sp,
                color: MainCubit.get(context).isDark
                    ? AppMainColors.orangeColor
                    : AppMainColors.whiteColor,
              ),
            ),
          ),
          body: state is CategoryDetailsLoadingStates
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : MainCubit.get(context)
                      .categoriesDetailModel!
                      .data!
                      .productData!
                      .isEmpty
                  ? Column(
                      children: [
                        SvgPicture.asset(Assets.imagesNodata),
                        Text(
                          'Coming Soon',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20.0).r,
                      itemBuilder: (context, index) {
                        return ProductItemBuilder(
                          productData: MainCubit.get(context)
                              .categoriesDetailModel!
                              .data!
                              .productData![index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                      itemCount: MainCubit.get(context)
                          .categoriesDetailModel!
                          .data!
                          .productData!
                          .length,
                    ),
        );
      },
    );
  }
}

class ProductItemBuilder extends StatelessWidget {
  const ProductItemBuilder({super.key, required this.productData});

  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MainCubit.get(context).getProductData(productData.id).then(
              (value) => navigateTo(
                context,
                ProductDetailsScreen(),
              ),
            );
      },
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ImageWithShimmer(
                imageUrl: '${productData.image}',
                width: double.infinity,
                height: 200.h,
                boxFit: BoxFit.fill,
              ),
              if (productData.discount != 0)
                Positioned.fill(
                  child: Align(
                    alignment: const Alignment(1, -1),
                    child: ClipRect(
                      child: Banner(
                        message: 'OFFERS',
                        textStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          letterSpacing: 0.5,
                        ),
                        location: BannerLocation.topStart,
                        color: Colors.red,
                        child: Container(
                          height: 100.h,
                        ),
                      ),
                    ),
                  ),
                ),
            ]),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6).r,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    '${productData.name}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${productData.price} LE',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      if (productData.discount != 0)
                        Text(
                          '${productData.oldPrice} LE',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppMainColors.greyColor,
                                  ),
                        ),
                      const Spacer(),
                      Text(
                        '${productData.discount} % OFF',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppMainColors.redColor,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
