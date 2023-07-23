import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_marko/Screens/category_details/category_details.dart';
import 'package:super_marko/model/category/category_model.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => catList(
              MainCubit.get(context).categoriesModel!.data!.data[index],
              context),
          separatorBuilder: (context, index) => const MyDivider(),
          itemCount: MainCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget catList(DataModel model, context) => InkWell(
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
              const SizedBox(
                width: 20.0,
              ),
              Text(
                model.name!.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ],
          ),
        ),
      );
}
