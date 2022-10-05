
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/product_detalis/product_details.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/model/cart/get_cart_model.dart';
import 'package:mego_market/shared/componnetns/components.dart';
import 'package:mego_market/shared/componnetns/constants.dart';

class CartScreen extends StatelessWidget {
  TextEditingController counterController = TextEditingController();

  CartScreen({Key? key}) : super(key: key);

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
        return MainCubit.get(context).cartModel!.data!.cartItems!.isEmpty
            ? Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 70,
                        color: Colors.greenAccent,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your Cart is empty',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Be Sure to fill your cart with something you like',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                ),
              )
            : Scaffold(
                body: SingleChildScrollView(
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
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: cartLength,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'The number of pieces :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Spacer(),
                                Text(' $cartLength  items',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('TOTAL :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                const Spacer(),
                                Text('${cartModel!.data!.total} LE',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 60,
                    ),
                  ]),
                ),
              );
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.none,
        elevation: 20,
        child: Container(
          height: 455,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image(
                image: NetworkImage('${model.product!.image}'),
                width: double.infinity,
                height: 250,
              ),
              Text(
                '${model.product!.name}',
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              space(double.infinity, 5),
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Price :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(
                          ' ${model.product!.price} LE',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        space(110, 0),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice}  LE',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: MaterialButton(
                            onPressed: () {
                              int quantity = model.quantity! - 1;
                              if (quantity != 0) {
                                MainCubit.get(context)
                                    .updateCartData(model.id!, quantity);
                              }
                            },
                            minWidth: 10,
                            //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.zero,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.remove,
                                size: 17,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${model.quantity}',
                          style: const TextStyle(fontSize: 25),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: MaterialButton(
                            onPressed: () {
                              int quantity = model.quantity! + 1;
                              if (quantity <= 5) {
                                MainCubit.get(context)
                                    .updateCartData(model.id!, quantity);
                              }
                            },
                            minWidth: 10,
                            //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.zero,
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add,
                                size: 17,
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
                                size: 30,
                              ),
                              const SizedBox(
                                width: 2.5,
                              ),
                              Text(
                                'Move to Favorites',
                                style: TextStyle(
                                  color: MainCubit.get(context)
                                          .favorites[model.product!.id]
                                      ? Colors.red
                                      : Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.grey,
                        ),
                        TextButton(
                          onPressed: () {
                            MainCubit.get(context).changeCart(model.product!.id!);
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.grey,
                                size: 18,
                              ),
                              SizedBox(
                                width: 2.5,
                              ),
                              Text('Remove',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  )),
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
