
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/cubit/cubit.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/model/faq/faq_model.dart';
import 'package:mego_market/shared/componnetns/components.dart';


class FqaScreen extends StatelessWidget {
  const FqaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: state is FaqLoadingStates
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'FAQ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildFQA(
                            MainCubit.get(context).faqModel!.data!.data![index],
                            context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: cubit.faqModel!.data!.data!.length,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget buildFQA(FqaData? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model!.question!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            Text(
              model.answer!,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
}
