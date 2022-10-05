
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/shared/componnetns/components.dart';
import 'package:mego_market/shared/styles/colors.dart';
import 'package:mego_market/shared/styles/icon_broken.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return MainCubit.get(context).favoritesModel!.data!.data!.isEmpty
            ? Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.favorite_border,
                        size: 70,
                        color: Colors.greenAccent,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your Favorites is empty',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Be sure to fill your favorite with something you like',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                ),
              )
            : Scaffold(
                body: ConditionalBuilder(
                  condition: state is! FavoritesLoadingStates,
                  builder: (context) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildListProduct(
                        MainCubit.get(context)
                            .favoritesModel!
                            .data!
                            .data![index]
                            .product,
                        context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount:
                        MainCubit.get(context).favoritesModel!.data!.data!.length,
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              );
      },
    );
  }

  Widget buildListProduct(
    model,
    context, {
    isOldPrice = true,
  }) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 400.0,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image,
                    ),
                    height: 250.0,
                    width: double.infinity,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      color: Colors.red,
                      child: const Text(
                        'OFFERS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: MainCubit.get(context).cart[model.id]
                          ? Colors.deepOrangeAccent
                          : Colors.grey[300],
                      child: IconButton(
                        onPressed: () {
                          MainCubit.get(context).changeCart(model.id);
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(height: 1.5),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: const TextStyle(
                            color: dColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            '${model.oldPrice.round()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor:
                              MainCubit.get(context).favorites[model.id]
                                  ? Colors.red
                                  : Colors.grey[300],
                          child: IconButton(
                            onPressed: () {
                              MainCubit.get(context).changeFavorites(model.id);
                            },
                            icon: const Icon(
                              IconBroken.Delete,
                              color: Colors.white,
                            ),
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
