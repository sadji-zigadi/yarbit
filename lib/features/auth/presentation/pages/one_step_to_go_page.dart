import 'package:auto_route/auto_route.dart';
import 'package:client/core/system/presentation/controller/language_cubit.dart';
import 'package:client/main.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/language_functions.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../../core/utils/wilaya_communes.dart';
import '../controller/details/details_cubit.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../widgets/back_button.dart';
import '../../../../injection_container.dart' as ic;

@RoutePage()
class OneStepToGoPage extends StatefulWidget implements AutoRouteWrapper {
  const OneStepToGoPage({super.key});

  @override
  State<OneStepToGoPage> createState() => _OneStepToGoPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailsCubit>(
          create: (context) => ic.sl<DetailsCubit>(),
        ),
        BlocProvider(
          create: (context) => ic.sl<LanguageCubit>(),
        ),
      ],
      child: this,
    );
  }
}

class _OneStepToGoPageState extends State<OneStepToGoPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumCtrl = TextEditingController();
  String? selWilaya;
  String? selCommune;
  late String language;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    language = trans(context).english;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildContent(),
        const SafeArea(child: BackButtonCustom()),
      ],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            left: 15,
            right: 15,
            bottom: 270,
          ),
          child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle(),
                const SizedBox(height: 35),
                _buildDetails(),
                const Spacer(),
                _buildBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      trans(context).oneStepToGo,
      style: AppTextStyles.h2,
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildLanguage(),
        const SizedBox(height: 30),
        _buildAddress(),
        const SizedBox(height: 30),
        _buildPhoneNumber(),
      ],
    );
  }

  Widget _buildLanguage() {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.accentBlack.withOpacity(0.3),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          trans(context).language,
          style: AppTextStyles.bodySmallHeavy,
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          items: <String>[
            trans(context).english,
            trans(context).french,
            trans(context).arabic,
          ]
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppTextStyles.body,
                  ),
                ),
              )
              .toList(),
          isExpanded: true,
          icon: Icon(
            Iconsax.arrow_down_1,
            color: AppColors.accentBlack,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Iconsax.flag,
              color: AppColors.accentBlack,
            ),
            errorBorder: border.copyWith(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: border,
            focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            disabledBorder: border,
            enabledBorder: border,
          ),
          value: language,
          onChanged: (value) {
            setState(() {
              language = value!;
            });
          },
          hint: Text(language),
        ),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          trans(context).address,
          style: AppTextStyles.bodySmallHeavy,
        ),
        const SizedBox(height: 10),
        Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField(
                  items: wilayasCommunes.keys
                      .map(
                        (wilaya) => DropdownMenuItem<String>(
                          value: wilaya,
                          child: Text(
                            wilaya,
                            style: AppTextStyles.body
                                .copyWith(color: AppColors.accentBlack),
                          ),
                        ),
                      )
                      .toList(),
                  value: selWilaya,
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != selWilaya) {
                      selCommune = null;
                    }

                    setState(() {
                      selWilaya = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return trans(context).pleaseSelectAWilaya;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: DropdownButtonFormField(
                  items: wilayasCommunes[selWilaya]
                      ?.map(
                        (commune) => DropdownMenuItem(
                          value: commune,
                          child: Text(
                            commune,
                            style: AppTextStyles.body
                                .copyWith(color: AppColors.accentBlack),
                          ),
                        ),
                      )
                      .toList(),
                  value: selCommune,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      selCommune = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return trans(context).pleaseSelectACommune;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trans(context).phoneNumber,
          style: AppTextStyles.bodySmallHeavy,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _phoneNumCtrl,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildBtn() {
    late String languageCode;

    if (language == trans(context).french) {
      languageCode = 'fr';
    } else if (language == trans(context).arabic) {
      languageCode = 'ar';
    } else {
      languageCode = 'en';
    }

    return BlocConsumer<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return const LoadingWidget();
        } else {
          return BlocListener<LanguageCubit, LanguageState>(
            listener: (context, state) {
              if (state is LanguageChanged) {
                YarbitClient.of(context)?.setLocale(Locale(languageCode));
              }
            },
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    _phoneNumCtrl.text.isNotEmpty &&
                    selWilaya != null &&
                    selCommune != null) {
                  await context
                      .read<LanguageCubit>()
                      .selectLanguage(context, languageCode);

                  context.read<DetailsCubit>().setDetails(
                        context,
                        wilaya: selWilaya!,
                        commune: selCommune!,
                        phoneNum: _phoneNumCtrl.text,
                        language: language,
                      );
                } else {
                  showSnackBar(
                    context,
                    message: trans(context).fillAllRequiredFields,
                    isError: true,
                  );
                }
              },
              child: Text(
                trans(context).continueBtn,
                style: AppTextStyles.bodyHeavy.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is DetailsFailure) {
          showSnackBar(
            context,
            message: state.message,
            isError: true,
          );
        } else if (state is DetailsSuccess) {
          showSnackBar(
            context,
            message: trans(context).detailsSavedSuccessfully,
          );
          context.router.pushAndPopUntil(
            const AppRoute(),
            predicate: (_) => false,
          );
        }
      },
    );
  }
}
