import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/search/cubit/cubit.dart';
import 'package:mego_market/Screens/search/cubit/state.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/model/search/search_model.dart';
import 'package:mego_market/shared/components/components.dart';
import 'package:mego_market/shared/styles/colors.dart';

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
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      focusNode: FocusNode(),
                      controller: SearchCubit.get(context).searchController,
                      keyboardType: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Text to get Search';
                        }
                        return null;
                      },
                      onFieldSubmitted: (text) {
                        SearchCubit.get(context).getSearch(text: text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (state is SearchLoadingStates)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .products[index],
                              context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount:
                              SearchCubit.get(context).searchModel!.data!.total,
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

  Widget buildListProduct(SearchProductModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image!,
                    ),
                    width: 120.0,
                    height: 120.0,
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
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.5),
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
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor:
                              MainCubit.get(context).favorites[model.id]
                                  ? Colors.red
                                  : Colors.grey[300],
                          child: IconButton(
                            onPressed: () {
                              MainCubit.get(context).changeFavorites(model.id!);
                            },
                            icon: const Icon(
                              Icons.star_border,
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
