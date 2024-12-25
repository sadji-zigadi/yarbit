import 'package:auto_route/auto_route.dart';
import 'package:client/core/shared/widgets/custom_app_bar.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:client/core/utils/error_messages.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/features/auth/presentation/widgets/loading_widget.dart';
import 'package:client/features/home/presentation/widgets/circle_image_widget.dart';
import 'package:client/features/orders/presentation/controllers/orders/orders_cubit.dart';
import 'package:client/features/orders/presentation/widgets/order_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
class OrdersPage extends StatefulWidget implements AutoRouteWrapper {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OrdersCubit>(
      create: (context) => ic.sl<OrdersCubit>(),
      child: this,
    );
  }
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: trans(context).orders,
        customActions: const [CircleImage()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return await context.read<OrdersCubit>().getOrders();
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 26,
            left: 12,
            right: 12,
          ),
          child: _buildOrders(),
        ),
      ),
    );
  }

  Widget _buildOrders() {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersSuccess) {
          if (state.orders.isNotEmpty) {
            return ListView.separated(
              itemCount: state.orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  OrderListTileWidget(order: state.orders[index]),
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: 100.h - kToolbarHeight - kBottomNavigationBarHeight,
                  child: Center(
                    child: Text(
                      trans(context).noOrdersFound,
                      style: AppTextStyles.body,
                    ),
                  ),
                ),
              ],
            );
          }
        } else if (state is OrdersFailure) {
          return Center(
            child: Text(
              errorMsg(context, code: state.message),
              style: AppTextStyles.body,
            ),
          );
        } else if (state is OrdersLoading) {
          return const Center(
            child: LoadingWidget(
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.main,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
