import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_marko/generated/assets.dart';
import 'package:super_marko/model/favorite/favorite_model.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: MainCubit.get(context).favoritesModel!.data!.data!.isEmpty
              ? Column(
                  children: [
                    SvgPicture.asset(Assets.imagesNodata),
                    Text(
                      'Your Favorites is empty',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Be sure to fill your favorite with something you like',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                )
              : ConditionalBuilder(
                  condition: state is! FavoritesLoadingStates,
                  builder: (context) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ProductList(
                      favoritesModel: MainCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data![index],
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0).r,
                      child: const MyDivider(),
                    ),
                    itemCount: MainCubit.get(context)
                        .favoritesModel!
                        .data!
                        .data!
                        .length,
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
        );
      },
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.favoritesModel});

  final bool isOldPrice = true;
  final FavoritesData favoritesModel;

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(15).r,
      child: Container(
        width: double.infinity,
        height: 105.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0).r,
          color: cubit.isDark
              ? AppMainColors.mainColor
              : AppMainColors.orangeColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0).r,
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppMainColors.whiteColor,
                  borderRadius: BorderRadius.circular(8.0).r,
                ),
                width: 90.w,
                height: double.infinity,
                child: ImageWithShimmer(
                  imageUrl: favoritesModel.product!.image!,
                  width: 90.w,
                  height: double.infinity,
                  boxFit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favoritesModel.product!.name!,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${favoritesModel.product!.price.round()} EGP',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppMainColors.whiteColor),
                        ),
                        if (favoritesModel.product!.discount != 0 && isOldPrice)
                          Text(
                            '${favoritesModel.product!.oldPrice.round()} EGP',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppMainColors.greyColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppMainColors.whiteColor,
                          child: IconButton(
                            icon: Icon(
                              IconBroken.Heart,
                              color: cubit.favorites[favoritesModel.product!.id]
                                  ? AppMainColors.redColor
                                  : Colors.grey,
                              size: 24.sp,
                            ),
                            onPressed: () {
                              cubit
                                  .changeFavorites(favoritesModel.product!.id!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
