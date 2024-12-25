import '../../../../core/utils/language_functions.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/text_field_type.dart';

class TextFormFieldCustom extends StatefulWidget {
  final String hintText;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final TextFieldType type;
  final InputBorder? borders;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool enabled;
  const TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    required this.type,
    this.borders,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.isPassword = false,
    this.enabled = true,
  });

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.isPassword && _isObscure,
      keyboardType: keyboardType(widget.type),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.accentBlack),
        suffixIcon: GestureDetector(
          onTap: widget.onTap,
          child: _buildIcon(),
        ),
        enabledBorder: widget.borders,
        errorBorder: widget.borders,
        focusedErrorBorder: widget.borders,
        disabledBorder: widget.borders,
        focusedBorder: widget.borders,
        border: widget.borders,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return trans(context).pleaseProvideAValue;
        }

        if (widget.type == TextFieldType.email) {
          if (!value.isValidEmail()) {
            return trans(context).pleaseProvideAValidEmail;
          }
        }
        return null;
      },
    );
  }

  Widget _buildIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _isObscure ? Iconsax.eye : Iconsax.eye_slash,
          color: AppColors.accentBlack.withOpacity(0.7),
        ),
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
      );
    } else {
      return Icon(
        widget.suffixIcon,
        color: AppColors.accentBlack.withOpacity(0.7),
      );
    }
  }

  TextInputType keyboardType(TextFieldType type) {
    return switch (type) {
      TextFieldType.email => TextInputType.emailAddress,
      TextFieldType.text => TextInputType.text,
      TextFieldType.phoneNumber => TextInputType.phone,
      _ => TextInputType.text,
    };
  }
}
