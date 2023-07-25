import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_marko/Screens/product_details/product_details.dart';
import 'package:super_marko/generated/assets.dart';
import 'package:super_marko/model/cart/get_cart_model.dart';
import 'package:super_marko/shared/components/constants.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final TextEditingController counterController = TextEditingController();

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
        if (state is ChangeCartSuccessStates) {
          if (state.model.status!) {
            showToast(
              text: state.model.message!,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        CartModel? cartModel = MainCubit.get(context).cartModel;
        cartLength = MainCubit.get(context).cartModel!.data!.cartItems!.length;
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
            body: MainCubit.get(context).cartModel!.data!.cartItems!.isEmpty
                ? Column(
                    children: [
                      SvgPicture.asset(Assets.imagesNodata),
                      Text(
                        'Your Cart is empty',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Be Sure to fill your cart with something you like',
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => cartProducts(
                            MainCubit.get(context)
                                .cartModel!
                                .data!
                                .cartItems![index],
                            context),
                        separatorBuilder: (context, index) => const MyDivider(),
                        itemCount: cartLength,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.h,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: AppMainColors.orangeColor,
                            shape: BoxShape.rectangle,
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(15).r,
                          ),
                          padding: const EdgeInsets.all(8).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'The number of pieces :',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '$cartLength Items',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: AppMainColors.whiteColor,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'TOTAL :',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${cartModel!.data!.total} LE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: AppMainColors.whiteColor,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60.h,
                      ),
                    ]),
                  ));
      },
    );
  }

  Widget cartProducts(
    CartItems model,
    context,
  ) {
    counterController.text = '${model.quantity}';
    return InkWell(
      onTap: () {
        MainCubit.get(context)
            .getProductData(model.product!.id)
            .then((value) => navigateTo(context, ProductDetailsScreen()));
      },
      child: Card(
        margin: const EdgeInsets.all(8).r,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: MainCubit.get(context).isDark
                ? AppMainColors.greyDarkColor
                : AppMainColors.whiteColor,
          ),
          borderRadius: BorderRadius.circular(20).r,
        ),
        clipBehavior: Clip.none,
        elevation: 20,
        child: Container(
          height: 400.h,
          padding: const EdgeInsets.all(15).r,
          child: Column(
            children: [
              ImageWithShimmer(
                imageUrl: '${model.product!.image}',
                width: double.infinity,
                height: 250.h,
                boxFit: BoxFit.fill,
              ),
              Text(
                '${model.product!.name}',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(20).r,
                ),
                padding: const EdgeInsets.all(8).r,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Price :',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          ' ${model.product!.price} LE',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: AppMainColors.orangeColor,
                                  ),
                        ),
                        SizedBox(width: 20.w),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice}  LE',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppMainColors.greyColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: MaterialButton(
                            onPressed: () {
                              int quantity = model.quantity! - 1;
                              if (quantity != 0) {
                                MainCubit.get(context)
                                    .updateCartData(model.id!, quantity);
                              }
                            },
                            minWidth: 10.w,
                            height: 10.h,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20).r,
                            ),
                            padding: EdgeInsets.zero,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.remove,
                                size: 17.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          '${model.quantity}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: MaterialButton(
                            onPressed: () {
                              int quantity = model.quantity! + 1;
                              if (quantity <= 5) {
                                MainCubit.get(context)
                                    .updateCartData(model.id!, quantity);
                              }
                            },
                            minWidth: 10.w,
                            height: 10.h,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20).r,
                            ),
                            padding: EdgeInsets.zero,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add,
                                size: 17.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            MainCubit.get(context)
                                .changeFavorites(model.product!.id!);
                          },
                          child: Row(
                            children: [
                              Icon(
                                MainCubit.get(context)
                                        .favorites[model.product!.id]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: MainCubit.get(context)
                                        .favorites[model.product!.id]
                                    ? Colors.red
                                    : Colors.grey,
                                size: 30.sp,
                              ),
                              SizedBox(
                                width: 2.5.sp,
                              ),
                              Text(
                                'Move to Favorites',
                                style: TextStyle(
                                  color: MainCubit.get(context)
                                          .favorites[model.product!.id]
                                      ? Colors.red
                                      : Colors.grey,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          height: 20.h,
                          width: 1.w,
                          color: AppMainColors.greyColor,
                        ),
                        TextButton(
                          onPressed: () {
                            MainCubit.get(context)
                                .changeCart(model.product!.id!);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_forever_outlined,
                                color: AppMainColors.greyColor,
                                size: 18.sp,
                              ),
                              SizedBox(
                                width: 2.5.w,
                              ),
                              Text(
                                'Remove',
                                style: TextStyle(
                                  color: AppMainColors.greyColor,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
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
