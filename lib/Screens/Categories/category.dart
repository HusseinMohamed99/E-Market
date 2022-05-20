// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/category_details/category_details.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/model/category/category_model.dart';
import 'package:mego_market/shared/componnetns/components.dart';


class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => CatList(
              MainCubit.get(context).categoriesModel!.data!.data[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: MainCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget CatList(DataModel model, context) => InkWell(
        onTap: () {
          MainCubit.get(context).getCategoriesDetailData(model.id!);
          navigateTo(context, CategoryProductsScreen(model.name!));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 100.0,
                height: 100.0,
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
              SizedBox(
                width: 20.0,
              ),
              Text(
                model.name!.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ],
          ),
        ),
      );
}
