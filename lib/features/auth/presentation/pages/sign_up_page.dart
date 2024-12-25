import 'package:auto_route/auto_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controller/sign_up_cubit/sign_up_cubit.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/language_functions.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../../core/utils/text_field_type.dart';
import '../widgets/back_button.dart';
import '../widgets/text_form_field_custom.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
class SignUpPage extends StatefulWidget implements AutoRouteWrapper {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => ic.sl<SignUpCubit>(),
      child: this,
    );
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
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
        _buildSignup(context),
        const SafeArea(child: BackButtonCustom()),
      ],
    );
  }

  Widget _buildSignup(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 150,
            horizontal: 15,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          trans(context).createAnAccountTitle,
          style: AppTextStyles.h2,
        ),
        RichText(
          text: TextSpan(
            style: AppTextStyles.caption,
            children: <TextSpan>[
              TextSpan(
                  text: '${trans(context).enterYourAccountDetailsBelowOr} '),
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

  Form _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormFieldCustom(
            controller: nameCtrl,
            hintText: trans(context).fullName,
            suffixIcon: Iconsax.user,
            type: TextFieldType.text,
          ),
          const SizedBox(height: 20),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              if (state is EmailError) {
                return TextFormFieldCustom(
                  controller: emailCtrl,
                  hintText: trans(context).email,
                  type: TextFieldType.email,
                  suffixIcon: Iconsax.sms,
                  borders: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ).animate().shakeX(duration: 700.ms);
              }
              return TextFormFieldCustom(
                controller: emailCtrl,
                hintText: trans(context).email,
                type: TextFieldType.email,
                suffixIcon: Iconsax.sms,
              );
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              if (state is PasswordError) {
                return Column(
                  children: [
                    TextFormFieldCustom(
                      controller: passwordCtrl,
                      hintText: trans(context).password,
                      isPassword: true,
                      type: TextFieldType.text,
                      borders: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ).animate().shakeX(duration: 700.ms),
                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: confirmPasswordCtrl,
                      hintText: trans(context).confirmPassword,
                      isPassword: true,
                      type: TextFieldType.text,
                      borders: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ).animate().shakeX(duration: 700.ms),
                  ],
                );
              } else {
                return Column(
                  children: [
                    TextFormFieldCustom(
                      controller: passwordCtrl,
                      hintText: trans(context).password,
                      isPassword: true,
                      type: TextFieldType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: confirmPasswordCtrl,
                      hintText: trans(context).confirmPassword,
                      isPassword: true,
                      type: TextFieldType.text,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      builder: (context, state) {
        if (state is SignUpLoading) {
          return const LoadingWidget();
        } else {
          return ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (passwordCtrl.text == confirmPasswordCtrl.text) {
                  context.read<SignUpCubit>().signUp(
                        context,
                        name: nameCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      );
                } else {
                  showSnackBar(
                    context,
                    message: trans(context).passwordsDoNotMatch,
                    isError: true,
                  );
                  context.read<SignUpCubit>().passwordError();
                }
              }
            },
            child: Text(trans(context).signUp),
          );
        }
      },
      listener: (context, state) {
        if (state is SignUpSuccess) {
          showSnackBar(
            context,
            message: trans(context).accountCreatedSuccessfully,
          );
          context.router.push(const OneStepToGoRoute());
        } else if (state is SignUpFailure) {
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
