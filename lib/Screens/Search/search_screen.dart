import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_marko/Screens/search/cubit/cubit.dart';
import 'package:super_marko/Screens/search/cubit/state.dart';
import 'package:super_marko/model/search/search_model.dart';
import 'package:super_marko/shared/components/image_with_shimmer.dart';
import 'package:super_marko/shared/components/my_divider.dart';
import 'package:super_marko/shared/components/text_form_field.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DefaultTextFormField(
                      focusNode: FocusNode(),
                      controller: cubit.searchController,
                      keyboardType: TextInputType.text,
                      validate: (String? value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter Text to get Search';
                        }
                        return null;
                      },
                      onFieldSubmitted: (text) {
                        cubit.getSearch(text: text);
                      },
                      label: 'Search',
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
                          separatorBuilder: (context, index) =>
                              const MyDivider(),
                          itemCount: cubit.searchModel!.data!.total,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.searchProductModel});

  final SearchProductModel searchProductModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                // Image(
                //   image: NetworkImage(
                //     searchProductModel.image!,
                //   ),
                //   width: 120.0,
                //   height: 120.0,
                // ),
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppMainColors.orangeColor,
                            ),
                      ),
                      SizedBox(width: 10.w),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: MainCubit.get(context)
                                .favorites[searchProductModel.id]
                            ? Colors.red
                            : Colors.grey[300],
                        child: IconButton(
                          onPressed: () {
                            MainCubit.get(context)
                                .changeFavorites(searchProductModel.id!);
                          },
                          icon: Icon(
                            IconBroken.Star,
                            color: AppMainColors.whiteColor,
                            size: 24.sp,
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
}
