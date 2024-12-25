import 'package:auto_route/auto_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../../core/utils/string_extensions.dart';
import '../controller/forget_password/forget_password_cubit.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/language_functions.dart';
import '../../../../injection_container.dart' as ic;
import '../widgets/back_button.dart';

@RoutePage()
class ForgetPasswordPage extends StatelessWidget implements AutoRouteWrapper {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();

  ForgetPasswordPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ForgetPasswordCubit>(
      create: (context) => ic.sl<ForgetPasswordCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildForgetPassword(context),
        const SafeArea(child: BackButtonCustom()),
      ],
    );
  }

  Widget _buildForgetPassword(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 150,
            left: 15,
            right: 15,
            bottom: 350,
          ),
          child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle(context),
                _buildEmail(context),
                _buildBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          trans(context).forgotPasswordTitle,
          style: AppTextStyles.h2,
        ),
        RichText(
          text: TextSpan(
            style: AppTextStyles.caption,
            children: <TextSpan>[
              TextSpan(text: '${trans(context).enterYourEmailBelowOr} '),
              TextSpan(
                  text: trans(context).logIn,
                  style: AppTextStyles.caption.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.router.push(const LogInRoute());
                    }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: emailCtrl,
        decoration: InputDecoration(
          labelText: trans(context).email,
          labelStyle: AppTextStyles.body.copyWith(
            color: AppColors.accentBlack,
          ),
          suffixIcon: Icon(
            Iconsax.sms,
            color: AppColors.accentBlack,
          ),
        ),
        validator: (value) {
          if (value == null) {
            return trans(context).emailIsRequired;
          }
          if (!value.isValidEmail()) {
            return trans(context).invalidEmailValidator;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) {
        if (state is ForgetPasswordLoading) {
          return const LoadingWidget();
        } else {
          return ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context
                    .read<ForgetPasswordCubit>()
                    .forgetPassword(context, email: emailCtrl.text);
              }
            },
            child: Text(trans(context).confirm),
          );
        }
      },
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          showSnackBar(
            context,
            message: trans(context).checkYourEmailForTheResetLink,
          );
          context.router.push(const LogInRoute());
        } else if (state is ForgetPasswordFailure) {
          showSnackBar(
            context,
            message: state.message,
            isError: true,
          );
        }
      },
    );
  }
}
