import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/Screens/category_details/category_details.dart';
import 'package:super_marko/model/category/category_model.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => CategoryList(
            model: MainCubit.get(context).categoriesModel!.data!.data[index],
          ),
          separatorBuilder: (context, index) => const MyDivider(),
          itemCount: MainCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.model});

  final DataModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MainCubit.get(context).getCategoriesDetailData(model.id!);
        navigateTo(context, CategoryProductsScreen(model.name!));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Row(
          children: [
            Container(
              width: 120.w,
              height: 90.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppMainColors.orangeColor, width: 2),
                image: DecorationImage(
                  image: NetworkImage(
                    model.image!,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
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
            Icon(
              Icons.arrow_forward_ios,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
