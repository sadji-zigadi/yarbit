import 'package:auto_route/auto_route.dart';
import 'package:client/core/routes/app_router.dart';
import 'package:client/core/shared/widgets/custom_app_bar.dart';
import 'package:client/core/utils/snackbar.dart';
import 'package:client/features/auth/presentation/controller/profile_info/profile_info_cubit.dart';
import 'package:client/features/auth/presentation/controller/sign_out_cubit/sign_out_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/language_functions.dart';
import '../widgets/profile_item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
class ProfilePage extends StatelessWidget implements AutoRouteWrapper {
  const ProfilePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SignOutCubit>(
      create: (context) => ic.sl<SignOutCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: trans(context).profile),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 50,
        ),
        child: _buildSettings(context),
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          trans(context).settings,
          style: AppTextStyles.bodySmallHeavy,
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            ProfileItemListTile(
              title: trans(context).accountSettings,
              prefixIcon: const Icon(
                Iconsax.monitor,
                color: Colors.black,
              ),
              isFirst: true,
              onPressed: () {
                context.router.push(AccountSettingsRoute(
                    cubit: context.read<ProfileInfoCubit>()));
              },
            ),
            ProfileItemListTile(
              title: trans(context).language,
              prefixIcon: const Icon(
                Iconsax.setting,
                color: Colors.black,
              ),
              onPressed: () {
                context.router.push(const LanguagesRoute());
              },
            ),
            BlocListener<SignOutCubit, SignOutState>(
              listener: (context, state) {
                if (state is SignOutSuccess) {
                  context.router.pushAndPopUntil(
                    const LogInRoute(),
                    predicate: (_) => false,
                  );
                  showSnackBar(
                    context,
                    message: trans(context).logOutSuccessfully,
                  );
                } else if (state is SignOutFailure) {
                  showSnackBar(
                    context,
                    message: state.message,
                  );
                }
              },
              child: ProfileItemListTile(
                title: trans(context).signOut,
                prefixIcon: const Icon(
                  Iconsax.logout,
                  color: Colors.black,
                ),
                isLast: true,
                onPressed: () {
                  context.read<SignOutCubit>().signOut(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
