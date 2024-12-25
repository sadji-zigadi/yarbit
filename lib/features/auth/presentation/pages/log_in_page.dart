import 'package:auto_route/auto_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/language_functions.dart';
import '../../../../core/utils/text_field_type.dart';
import '../controller/log_in_cubit/login_cubit.dart';
import '../widgets/text_form_field_custom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../../injection_container.dart' as ic;
import '../widgets/back_button.dart';
import '../widgets/loading_widget.dart';

@RoutePage()
class LogInPage extends StatefulWidget implements AutoRouteWrapper {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ic.sl<LoginCubit>(),
      child: this,
    );
  }
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildLogin(context),
          const SafeArea(child: BackButtonCustom()),
        ],
      ),
    );
  }

  Widget _buildLogin(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 150,
            bottom: 250,
            left: 15,
            right: 15,
          ),
          child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle(context),
                _buildForm(),
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
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              trans(context).welcomeBack,
              style: AppTextStyles.h2,
            ),
            RichText(
              text: TextSpan(
                style: AppTextStyles.caption,
                children: <TextSpan>[
                  TextSpan(text: '${trans(context).loginBelowOr} '),
                  TextSpan(
                      text: trans(context).createAnAccount,
                      style: AppTextStyles.caption.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.router.push(const SignUpRoute());
                        }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is EmailError || state is InvalidCredential) {
                return TextFormFieldCustom(
                  controller: emailCtrl,
                  hintText: trans(context).email,
                  type: TextFieldType.email,
                  borders: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ).animate().shakeX(duration: 700.ms);
              } else {
                return TextFormFieldCustom(
                  controller: emailCtrl,
                  hintText: trans(context).email,
                  type: TextFieldType.email,
                );
              }
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is PasswordError || state is InvalidCredential) {
                return TextFormFieldCustom(
                  controller: passwordCtrl,
                  hintText: trans(context).password,
                  type: TextFieldType.text,
                  isPassword: true,
                  borders: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ).animate().shakeX(duration: 700.ms);
              } else {
                return TextFormFieldCustom(
                  controller: passwordCtrl,
                  hintText: trans(context).password,
                  type: TextFieldType.text,
                  isPassword: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LogInLoading) {
          return Column(
            children: [
              const LoadingWidget(),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: trans(context).forgotPassword,
                  style: AppTextStyles.caption.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.router.push(ForgetPasswordRoute());
                    },
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginCubit>().logIn(
                          context,
                          email: emailCtrl.text,
                          password: passwordCtrl.text,
                        );
                  }
                },
                child: Text(trans(context).login),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: trans(context).forgotPassword,
                  style: AppTextStyles.caption.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.router.push(ForgetPasswordRoute());
                    },
                ),
              ),
            ],
          );
        }
      },
      listener: (context, state) {
        if (state is LoginSuccess) {
          showSnackBar(
            context,
            message: trans(context).connectedSuccessfully,
          );
          context.router.pushAndPopUntil(
            const AppRoute(),
            predicate: (_) => false,
          );
        } else if (state is LoginFailure) {
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
