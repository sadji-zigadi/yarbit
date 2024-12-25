import 'package:auto_route/auto_route.dart';
import 'package:client/core/routes/app_router.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/features/companies/presentation/controllers/categories/categories_cubit.dart';
import 'package:client/features/companies/presentation/controllers/companies/companies_cubit.dart';
import 'package:client/features/companies/presentation/pages/search_page.dart';
import '../../../../features/auth/presentation/controller/profile_info/profile_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/auth/presentation/controller/sign_out_cubit/sign_out_cubit.dart';
import '../../../../injection_container.dart' as ic;

late TabsRouter tabsRouter;

@RoutePage()
// ignore: must_be_immutable
class AppPage extends StatefulWidget implements AutoRouteWrapper {
  const AppPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignOutCubit>(
          create: (context) => ic.sl<SignOutCubit>(),
        ),
        BlocProvider<ProfileInfoCubit>(
          create: (context) => ic.sl<ProfileInfoCubit>(),
        ),
        BlocProvider<CompaniesCubit>(
          create: (context) => ic.sl<CompaniesCubit>(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => ic.sl<CategoriesCubit>(),
        ),
      ],
      child: this,
    );
  }

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();
    context.read<CompaniesCubit>().getCompanies(context);

    context.read<CategoriesCubit>().getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      routes: [
        const HomeRoute(),
        SearchRoute(key: searchPageKey),
        const OrdersRoute(),
        const ProfileRoute(),
      ],
      builder: (context, child) {
        tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: _buildNavBar(context, tabsRouter),
        );
      },
    );
  }

  Widget _buildNavBar(BuildContext context, TabsRouter tabsRouter) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        items: [
          _buildNavBarItem(
            icon: Iconsax.home_2,
            label: trans(context).home,
          ),
          _buildNavBarItem(
            icon: Iconsax.search_normal,
            label: trans(context).search,
          ),
          _buildNavBarItem(
            icon: Iconsax.category,
            label: trans(context).orders,
          ),
          _buildNavBarItem(
            icon: Iconsax.user,
            label: trans(context).profile,
          ),
        ],
        onTap: (value) {
          tabsRouter.setActiveIndex(value);
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      label: label,
      activeIcon: Icon(
        icon,
        color: AppColors.main,
      ),
    );
  }
}
