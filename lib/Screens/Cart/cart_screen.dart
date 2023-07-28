import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_marko/Screens/Orders/order_screen.dart';
import 'package:super_marko/generated/assets.dart';
import 'package:super_marko/model/cart/get_cart_model.dart';
import 'package:super_marko/shared/components/buttons.dart';
import 'package:super_marko/shared/components/constants.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/show_toast.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

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
              state: ToastStates.success,
            );
          }
        }
      },
      builder: (context, state) {
        cartLength = MainCubit.get(context).cartModel!.data!.cartItems!.length;
        return Scaffold(
          appBar: AppBar(
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
          body: MainCubit.get(context).cartModel!.data!.cartItems!.isEmpty
              ? SingleChildScrollView(
                  child: Column(
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
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => CartProducts(
                        cartModel: MainCubit.get(context)
                            .cartModel!
                            .data!
                            .cartItems![index],
                        index: index,
                      ),
                      separatorBuilder: (context, index) => const MyDivider(),
                      itemCount: cartLength,
                    ),
                  ]),
                ),
          bottomNavigationBar: BottomAppBar(
            elevation: 20,
            color: AppMainColors.dividerColor,
            child: Container(
              color: MainCubit.get(context).isDark
                  ? AppMainColors.whiteColor
                  : AppColorsDark.primaryDarkColor,
              height: 110.h,
              child: Padding(
                padding: const EdgeInsets.all(15.0).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price :',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '${MainCubit.get(context).cartModel!.data!.total} EGP',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    defaultMaterialButton(
                      color: MainCubit.get(context).isDark
                          ? AppMainColors.mainColor
                          : AppMainColors.orangeColor,
                      context: context,
                      function: () {
                        if (MainCubit.get(context).cartModel!.data!.total !=
                            0) {
                          navigateTo(context, const OrderScreen());
                        }
                      },
                      textColor: AppMainColors.whiteColor,
                      text: 'CheckOut',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartProducts extends StatelessWidget {
  const CartProducts({super.key, required this.cartModel, required this.index});

  final CartItems cartModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    final TextEditingController counterController = TextEditingController();

    counterController.text = '${cartModel.quantity}';
    return Padding(
      padding: const EdgeInsets.all(15).r,
      child: Slidable(
        key: ValueKey(index),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                MainCubit.get(context).changeCart(cartModel.product!.id!);
              },
              foregroundColor: AppMainColors.redColor,
              icon: IconBroken.Delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(8.0).r,
            ),
          ],
        ),
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
            padding: const EdgeInsets.all(10).r,
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
                    imageUrl: cartModel.product!.image!,
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
                        '${cartModel.product!.name}',
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        '${cartModel.product!.price} EGP',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppMainColors.whiteColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (cartModel.product!.discount != 0)
                            Text(
                              '${cartModel.product!.oldPrice}  LE',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: AppMainColors.greyColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  int quantity = cartModel.quantity! - 1;
                                  if (quantity != 0) {
                                    MainCubit.get(context).updateCartData(
                                        cartModel.id!, quantity);
                                  }
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: AppMainColors.whiteColor,
                                  size: 24.sp,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  '${cartModel.quantity}',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  int quantity = cartModel.quantity! + 1;
                                  if (quantity <= 5) {
                                    MainCubit.get(context).updateCartData(
                                        cartModel.id!, quantity);
                                  }
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: AppMainColors.whiteColor,
                                  size: 24.sp,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
