// ignore_for_file: use_key_in_widget_constructors, unnecessary_string_interpolations, unnecessary_string_escapes, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/product_detalis/product_details.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/model/category/category_details_model.dart';
import 'package:mego_market/shared/componnetns/components.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  CategoryProductsScreen(this.categoryName);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {
        if (state is ChangeFavoritesSuccessStates) {
          if (state.model.status!) {
            ShowToast(
              text: state.model.message!,
              state: ToastStates.SUCCESS,
            );
          } else {
            ShowToast(
              text: state.model.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is CategoryDetailsLoadingStates
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MainCubit.get(context)
                      .categoriesDetailModel!
                      .data!
                      .productData!
                      .isEmpty
                  ? Scaffold(
                      body: Center(
                      child: Text(
                        'Coming Soon',
                        style: TextStyle(fontSize: 50),
                      ),
                    ))
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            GridView.count(
                              crossAxisCount: 1,
                              mainAxisSpacing: 0.1,
                              crossAxisSpacing: .1,
                              childAspectRatio: 1 / 1.1,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                  MainCubit.get(context)
                                      .categoriesDetailModel!
                                      .data!
                                      .productData!
                                      .length,
                                  (index) => MainCubit.get(context)
                                          .categoriesDetailModel!
                                          .data!
                                          .productData!
                                          .isEmpty
                                      ? Center(
                                          child: Text(
                                            'Soon',
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : productItemBuilder(
                                          MainCubit.get(context)
                                              .categoriesDetailModel!
                                              .data!
                                              .productData![index],
                                          context)),
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  Widget productItemBuilder(ProductData model, context) => InkWell(
        onTap: () {
          MainCubit.get(context)
              .getProductData(model.id)
              .then((value) => navigateTo(context, ProductDetailsScreen()));
        },
        child: Container(
          padding: EdgeInsetsDirectional.only(start: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 250,
                  width: double.infinity,
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      MainCubit.get(context).changeFavorites(model.id!);
                    },
                    icon: Icon(
                      MainCubit.get(context).favorites[model.id]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: MainCubit.get(context).favorites[model.id]
                          ? Colors.red
                          : Colors.grey,
                      size: 35,
                    ),
                  ),
                ),
                if (model.discount != 0)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment(1, -1),
                      child: ClipRect(
                        child: Banner(
                          message: 'OFFERS',
                          textStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                          location: BannerLocation.topStart,
                          color: Colors.red,
                          child: Container(
                            height: 100.0,
                          ),
                        ),
                      ),
                    ),
                  ),
              ]),
              SizedBox(height: 10),
              Text(
                '${model.name}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${model.price}\ LE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice}\ LE',
                      style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                  Spacer(),
                  Text(
                    '${model.discount}\ % OFF',
                    style: TextStyle(color: Colors.red, fontSize: 11),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
