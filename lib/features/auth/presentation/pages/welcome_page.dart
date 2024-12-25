import 'package:auto_route/auto_route.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/language_functions.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 80,
          bottom: 33,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogo(),
            _buildImg(),
            _buildAuthBtns(context),
            _buildTermsAndConditions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/alternative logo 6.png'),
        Text(
          'Link the work...to your Home',
          style: AppTextStyles.bodySmall.copyWith(
            color: const Color(0xFF292D32),
          ),
        ),
      ],
    );
  }

  Widget _buildImg() {
    return Image.asset('assets/images/picture_welcome_page.png');
  }

  Widget _buildAuthBtns(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            context.router.push(const SignUpRoute());
          },
          child: Text(trans(context).signUp),
        ),
        const SizedBox(height: 7.0),
        ElevatedButton(
          onPressed: () {
            context.router.push(const LogInRoute());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentWhite,
            foregroundColor: AppColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: Colors.black.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Text(trans(context).login),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final url = Uri.parse('http://www.yarbit.net/terms');
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
      style: TextButton.styleFrom(
        textStyle: AppTextStyles.bodySmallHeavy,
        foregroundColor: AppColors.accentBlack,
      ),
      child: Text(
        trans(context).termsAndConditions,
      ),
    );
  }
}
