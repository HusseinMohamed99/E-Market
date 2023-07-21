import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:super_marko/Screens/cart/cart.dart';
import 'package:super_marko/cubit/cubit.dart';
import 'package:super_marko/cubit/state.dart';
import 'package:super_marko/shared/components/components.dart';

class ProductDetailsScreen extends StatelessWidget {
  final PageController productImages = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        var model = cubit.productResponse!.data;

        return ConditionalBuilder(
          condition: cubit.productResponse != null,
          builder: (context) => SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('${model!.name}'),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  controller: productImages,
                                  itemBuilder: (context, index) =>
                                      Image.network(model.images![index]),
                                  itemCount: model.images!.length,
                                ),
                                Positioned(
                                  top: 10,
                                  left: 20,
                                  child: IconButton(
                                    onPressed: () {
                                      MainCubit.get(context)
                                          .changeFavorites(model.id!);
                                    },
                                    icon: Icon(
                                      MainCubit.get(context).favorites[model.id]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: MainCubit.get(context)
                                              .favorites[model.id]
                                          ? Colors.red
                                          : Colors.grey,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SmoothPageIndicator(
                            controller: productImages,
                            count: model.images!.length,
                            effect: ExpandingDotsEffect(
                                dotColor: Colors.grey.shade300,
                                activeDotColor: Colors.deepOrange,
                                expansionFactor: 1.01,
                                dotHeight: 15,
                                dotWidth: 15,
                                spacing: 12),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Price:  ${model.price}  LE',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1),
                                  ),
                                  const Spacer(),
                                  if (model.discount != 0)
                                    Text(
                                      '${model.discount}' '% OFF',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          height: 1),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          myDivider(),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                myDivider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${model.description}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: MaterialButton(
                          color: Colors.deepOrangeAccent,
                          onPressed: () {
                            if (MainCubit.get(context).cart[model.id]) {
                              showToast(
                                state: ToastStates.success,
                                text:
                                    'Already in Your Cart \nCheck your cart To Edit or Delete ',
                              );
                            } else {
                              MainCubit.get(context).changeCart(model.id!);
                              scaffoldKey.currentState!.showBottomSheet(
                                (context) => Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${model.name}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Added to Cart',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                  'CONTINUE SHOPPING')),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              navigateTo(context, CartScreen());
                                              MainCubit.get(context)
                                                  .getCartData();
                                            },
                                            child: const Text('CHECKOUT'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                elevation: 50,
                              );
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
