import 'package:auto_route/auto_route.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/shared/pages/app_page.dart';
import 'package:client/core/system/presentation/pages/languages_page.dart';
import 'package:client/features/auth/presentation/controller/profile_info/profile_info_cubit.dart';
import 'package:client/features/auth/presentation/pages/account_settings_page.dart';
import 'package:client/features/orders/presentation/pages/company_detail_page.dart';
import 'package:client/features/orders/presentation/pages/orders_page.dart';
import '../../features/companies/presentation/pages/search_page.dart';
import 'auth_guard.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/forget_password_page.dart';
import '../../features/auth/presentation/pages/log_in_page.dart';
import '../../features/auth/presentation/pages/one_step_to_go_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WelcomeRoute.page,
          guards: [AuthGuard()],
          initial: true,
        ),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: LogInRoute.page),
        AutoRoute(page: OneStepToGoRoute.page),
        AutoRoute(page: ForgetPasswordRoute.page),
        AutoRoute(
          page: AppRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: SearchRoute.page),
            AutoRoute(page: OrdersRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: CompanyDetailRoute.page),
        AutoRoute(page: LanguagesRoute.page),
        AutoRoute(page: AccountSettingsRoute.page),
      ];
}
