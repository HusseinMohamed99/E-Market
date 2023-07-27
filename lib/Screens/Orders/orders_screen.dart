import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:super_marko/shared/components/navigator.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/cubit/state.dart';
import 'package:super_marko/shared/styles/colors.dart';
import 'package:super_marko/shared/styles/icon_broken.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Orders',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            leading: IconButton(
              onPressed: () {
                pop(context);
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
          body: state is! GetOrdersLoadingState
              ? ListView.separated(
                  padding: const EdgeInsets.all(15.0),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            onPressed: (context) {
                              cubit.cancelOrder(
                                  id: cubit.ordersModel!.data!
                                      .ordersDetails![index].id!);
                              cubit.getOrders();
                            },
                            foregroundColor: Colors.red,
                            icon: IconBroken.Close_Square,
                            label: 'Cancel',
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ],
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[50],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text('Date:'),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        cubit.ordersModel!.data!
                                            .ordersDetails![index].date!,
                                        style: const TextStyle(
                                            color: Colors.redAccent),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Total:'),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        cubit.ordersModel!.data!
                                            .ordersDetails![index].total
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.redAccent),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                cubit.ordersModel!.data!.ordersDetails![index]
                                    .status!,
                                style: TextStyle(
                                    color: cubit.ordersModel!.data!
                                                .ordersDetails![index].status ==
                                            'New'
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10.0,
                    );
                  },
                  itemCount: 1)
              //  cubit.ordersModel!.data!.ordersDetails!.length,
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
