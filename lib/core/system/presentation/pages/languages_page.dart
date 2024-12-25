import 'package:auto_route/auto_route.dart';
import 'package:client/core/shared/widgets/custom_app_bar.dart';
import 'package:client/core/system/presentation/controller/language_cubit.dart';
import 'package:client/core/theme/app_colors.dart';
import 'package:client/core/theme/app_text_styles.dart';
import 'package:client/core/utils/language_functions.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
// ignore: must_be_immutable
class LanguagesPage extends StatefulWidget implements AutoRouteWrapper {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => ic.sl<LanguageCubit>(),
      child: this,
    );
  }
}

class _LanguagesPageState extends State<LanguagesPage> {
  bool arabic = false;
  bool english = false;
  bool french = false;

  late String languageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: trans(context).language,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      arabic = true;
                      english = false;
                      french = false;
                      languageCode = 'ar';
                    });
                  },
                  child: _buildLanguage(
                    language: 'Arabic',
                    isActive: arabic,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      arabic = false;
                      english = true;
                      french = false;
                      languageCode = 'en';
                    });
                  },
                  child: _buildLanguage(
                    language: 'English',
                    isActive: english,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      arabic = false;
                      english = false;
                      french = true;
                      languageCode = 'fr';
                    });
                  },
                  child: _buildLanguage(
                    language: 'French',
                    isActive: french,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildBtn(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguage({
    required String language,
    required bool isActive,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.20),
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          language,
          style: AppTextStyles.custom6,
        ),
        trailing: Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.main : Colors.white,
            border: Border.all(
              width: 1,
              color: AppColors.accentBlack.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
      listener: (context, state) {
        if (state is LanguageChanged) {
          context.router.maybePop();
          YarbitClient.of(context)?.setLocale(Locale(languageCode));
        }
      },
      child: ElevatedButton(
        onPressed: () {
          context.read<LanguageCubit>().selectLanguage(context, languageCode);
        },
        child: Text(trans(context).confirm),
      ),
    );
  }
}
