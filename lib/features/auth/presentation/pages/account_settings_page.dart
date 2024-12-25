import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/shared/widgets/custom_app_bar.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/core/utils/snackbar.dart';
import 'package:client/core/utils/text_field_type.dart';
import 'package:client/features/auth/presentation/controller/edit_profile_info/edit_profile_info_cubit.dart';
import 'package:client/features/auth/presentation/controller/profile_info/profile_info_cubit.dart';
import 'package:client/features/auth/presentation/widgets/loading_widget.dart';
import 'package:client/features/auth/presentation/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
class AccountSettingsPage extends StatefulWidget implements AutoRouteWrapper {
  final ProfileInfoCubit cubit;

  const AccountSettingsPage({required this.cubit, super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: cubit,
        ),
        BlocProvider(
          create: (context) => ic.sl<EditProfileInfoCubit>(),
        ),
      ],
      child: this,
    );
  }
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phonenumCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: trans(context).profile,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h - kToolbarHeight - MediaQuery.of(context).padding.top,
          width: 100.w,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 36,
              bottom: 32,
              left: 16,
              right: 16,
            ),
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                builder: (context, state) {
                  if (state is ProfileInfoSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPicture(state.user.pictureUrl),
                        _buildForm(
                          context,
                          emailHint: state.user.email,
                          nameHint: state.user.name,
                          phonenumHint: state.user.phoneNum,
                        ),
                        _buildButton(context),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPicture(),
                        _buildForm(context),
                        _buildButton(context),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPicture([String? pictureUrl]) {
    if (pictureUrl == null && _image == null) {
      return GestureDetector(
        onTap: () async {
          final returnedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          if (returnedImage != null) {
            setState(() {
              _image = File(returnedImage.path);
            });
          }
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: AppColors.accentBlack.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: const Icon(
            Iconsax.camera,
            size: 40,
          ),
        ),
      );
    } else if (pictureUrl == null && _image != null) {
      return GestureDetector(
        onTap: () async {
          final returnedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          if (returnedImage != null) {
            setState(() {
              _image = File(returnedImage.path);
            });
          }
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: FileImage(_image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () async {
        final returnedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (returnedImage != null) {
          setState(() {
            _image = File(returnedImage.path);
          });
        }
      },
      child: pictureUrl == null && _image == null
          ? Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: AppColors.accentBlack.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: const Icon(
                Iconsax.camera,
                size: 40,
              ),
            )
          : _image != null
              ? Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: pictureUrl!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    String? nameHint,
    String? phonenumHint,
    String? emailHint,
  }) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldCustom(
            controller: _nameCtrl,
            hintText: nameHint ?? trans(context).fullName,
            type: TextFieldType.text,
            suffixIcon: Iconsax.user,
          ),
          const SizedBox(height: 20),
          TextFormFieldCustom(
            controller: _phonenumCtrl,
            hintText: phonenumHint ?? '+213 555555555',
            type: TextFieldType.phoneNumber,
            suffixIcon: Iconsax.user,
          ),
          const SizedBox(height: 20),
          TextFormFieldCustom(
            controller: _emailCtrl,
            hintText: emailHint ?? 'email@gmail.com',
            type: TextFieldType.email,
            suffixIcon: Iconsax.user,
            enabled: false,
          ),
          const SizedBox(height: 20),
          TextFormFieldCustom(
            controller: _passwordCtrl,
            hintText: trans(context).password,
            type: TextFieldType.password,
            suffixIcon: Iconsax.user,
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return BlocConsumer<EditProfileInfoCubit, EditProfileInfoState>(
      listener: (context, state) {
        if (state is EditProfileInfoSuccess) {
          context.read<ProfileInfoCubit>().getProfileInfo(context);
          showSnackBar(
            context,
            message: trans(context).profileUpdated,
          );
          context.router.maybePop();
        } else if (state is EditProfileInfoFailure) {
          showSnackBar(
            context,
            message: state.message,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        if (state is EditProfileInfoLoading) {
          return const LoadingWidget();
        } else {
          return ElevatedButton(
            onPressed: () {
              if (_nameCtrl.text.isEmpty &&
                  _phonenumCtrl.text.isEmpty &&
                  _passwordCtrl.text.isEmpty &&
                  _image == null) {
                showSnackBar(
                  context,
                  message: trans(context).noChanges,
                  isError: true,
                );
              } else {
                context.read<EditProfileInfoCubit>().editProfileInfo(
                      context,
                      name: _nameCtrl.text.isEmpty ? null : _nameCtrl.text,
                      phoneNum: _phonenumCtrl.text.isEmpty
                          ? null
                          : _phonenumCtrl.text,
                      password: _passwordCtrl.text.isEmpty
                          ? null
                          : _passwordCtrl.text,
                      image: _image,
                    );
              }
            },
            child: Text(trans(context).apply),
          );
        }
      },
    );
  }
}
