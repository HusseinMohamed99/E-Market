import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/Screens/ProductDetails/product_details_screen.dart';
import 'package:super_marko/model/search/search_model.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/components/text_form_field.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController searchController = TextEditingController();
        final formKey = GlobalKey<FormState>();
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            leading: IconButton(
              onPressed: () {
                pop(context);
                searchController.clear();
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
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DefaultTextFormField(
                    focusNode: FocusNode(),
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter Text to get Search';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefixPressed: (text) {
                      cubit.getSearch(text: text);
                    },
                    prefix: IconBroken.Search,
                  ),
                  SizedBox(height: 20.h),
                  if (state is SearchLoadingStates)
                    const LinearProgressIndicator(),
                  SizedBox(height: 20.h),
                  if (state is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ProductList(
                          searchProductModel:
                              cubit.searchModel!.data!.products[index],
                        ),
                        separatorBuilder: (context, index) => const MyDivider(),
                        itemCount: cubit.searchModel!.data!.products.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.searchProductModel});

  final SearchProductModel searchProductModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MainCubit.get(context)
            .getProductData(searchProductModel.id)
            .then((value) => navigateTo(context, const ProductDetailsScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(20).r,
        child: SizedBox(
          height: 120.h,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ImageWithShimmer(
                    imageUrl: searchProductModel.image!,
                    width: 120.w,
                    height: 120.h,
                  ),
                ],
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchProductModel.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${searchProductModel.price.round()}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: AppMainColors.orangeColor,
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
