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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20).r,
      child: SizedBox(
        height: 320.h,
        child: Column(
          children: [
            Stack(
              children: [
                ImageWithShimmer(
                  imageUrl: favoritesModel.product!.image!,
                  height: 250.h,
                  width: double.infinity,
                ),
                if (favoritesModel.product!.discount != 0 && isOldPrice)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ).r,
                      color: AppMainColors.redColor,
                      child: Text(
                        'OFFERS',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppMainColors.whiteColor),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: MainCubit.get(context)
                            .favorites[favoritesModel.product!.id]
                        ? Colors.red
                        : Colors.grey[300],
                    child: IconButton(
                      onPressed: () {
                        MainCubit.get(context)
                            .changeFavorites(favoritesModel.product!.id!);
                      },
                      icon: Icon(
                        IconBroken.Heart,
                        color: AppMainColors.whiteColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    favoritesModel.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text(
                        '${favoritesModel.product!.price.round()}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppMainColors.redColor),
                      ),
                      SizedBox(width: 20.w),
                      if (favoritesModel.product!.discount != 0 && isOldPrice)
                        Text(
                          '${favoritesModel.product!.oldPrice.round()}',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppMainColors.greyColor,
                                    decoration: TextDecoration.lineThrough,
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
    );
  }
}
