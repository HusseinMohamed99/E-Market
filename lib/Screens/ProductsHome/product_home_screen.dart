import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:super_marko/Screens/CategoryDetails/category_details_screen.dart';
import 'package:super_marko/Screens/ProductDetails/product_details_screen.dart';
import 'package:super_marko/model/category/category_model.dart';
import 'package:super_marko/model/home/home_model.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

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
        return ConditionalBuilder(
          condition: MainCubit.get(context).homeModel != null &&
              MainCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              MainCubit.get(context).homeModel!,
              MainCubit.get(context).categoriesModel!,
              context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: CarouselSlider(
                items: model.data!.banners
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: NetworkImage('${e.image}'),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 140.0,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Scrollbar(
                      thickness: 1,
                      child: ListView.separated(
                        padding: const EdgeInsetsDirectional.only(
                            start: 10.0, top: 10),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => categoriesItem(
                            categoriesModel.data!.data[index], context),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10.0,
                        ),
                        itemCount: categoriesModel.data!.data.length,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 20.h),
                  StaggeredGridView.countBuilder(
                    padding: const EdgeInsets.symmetric(vertical: 15).r,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 3,
                    itemCount: model.data!.products.length,
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.count(1, index.isEven ? 1.8 : 1.4);
                    },
                    itemBuilder: (context, index) {
                      return GridProducts(
                          productModel: model.data!.products[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget categoriesItem(DataModel model, context) => InkWell(
        onTap: () {
          MainCubit.get(context).getCategoriesDetailData(model.id!);
          navigateTo(context, CategoryProductsScreen(model.name!));
        },
        child: SizedBox(
          width: 105,
          child: Column(
            children: [
              Container(
                width: 95.0,
                height: 82.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.deepOrange, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(
                      model.image!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                model.name!.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
}

class GridProducts extends StatelessWidget {
  const GridProducts({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return InkWell(
      onTap: () {
        MainCubit.get(context)
            .getProductData(productModel.id)
            .then((value) => navigateTo(context, const ProductDetailsScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: cubit.isDark
              ? AppMainColors.whiteColor
              : AppColorsDark.primaryDarkColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8).r,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                      child: ImageWithShimmer(
                        imageUrl: productModel.image!,
                        width: double.infinity,
                        height: double.infinity,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    if (productModel.discount != 0)
                      Positioned.fill(
                        child: Align(
                          alignment: const Alignment(1, -1),
                          child: ClipRect(
                            child: Banner(
                              message: 'Offers'.toUpperCase(),
                              textStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                letterSpacing: 0.5,
                              ),
                              location: BannerLocation.topStart,
                              color: AppMainColors.redColor,
                              child: Container(
                                height: 60.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5).r,
                child: Text(
                  productModel.name!,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${productModel.price} EGP',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppMainColors.redColor),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.changeFavorites(productModel.id!);
                    },
                    child: Icon(
                      IconBroken.Heart,
                      color: cubit.favorites[productModel.id]
                          ? AppMainColors.redColor
                          : AppMainColors.greyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
